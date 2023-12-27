param location string
param project string
param tags { *: string }
param storageAccountName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: storageAccountName
}

resource msi 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'id-${project}-depscript'
  location: location
}

var roleIds = {
  storageAccountContributor: '17d1049b-9a84-46fb-8f53-869881c3d3ab'
  storageBlobDataContributor: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
}

resource storageRoleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for roleId in items(roleIds): {
  scope: storageAccount
  name: guid(msi.id, roleId.value, storageAccount.id)
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleId.value)
    principalId: msi.properties.principalId
    principalType: 'ServicePrincipal'
  }
}]

resource enableStaticWebsite 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'depscript-${project}-enable-static-website'
  kind: 'AzureCLI'
  location: location
  tags: tags

  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${msi.id}': {}
    }
  }

  dependsOn: [ storageRoleAssignments ]

  properties: {
    retentionInterval: 'PT4H'
    azCliVersion: '2.54.0'
    scriptContent: 'az storage blob service-properties update --account-name ${storageAccount.name} --static-website --404-document error.html --index-document index.html'
  }
}

resource uploadBlobs 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'depscript-${project}-upload-blobs'
  kind: 'AzureCLI'
  location: location
  tags: tags

  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${msi.id}': {}
    }
  }

  dependsOn: [ enableStaticWebsite ]

  properties: {
    azCliVersion: '2.54.0'
    retentionInterval: 'PT4H'

    environmentVariables: [
      {
        name: 'AZURE_STORAGE_ACCOUNT'
        value: storageAccount.name
      }
      {
        name: 'INDEX_CONTENT'
        value: loadFileAsBase64('../src/index.html')
      }
      {
        name: 'ERROR_CONTENT'
        value: loadFileAsBase64('../src/error.html')
      }
      {
        name: 'CSS_CONTENT'
        value: loadFileAsBase64('../src/main.css')
      }
    ]

    scriptContent: '''
echo "$INDEX_CONTENT" | base64 -d > index.html
echo "$ERROR_CONTENT" | base64 -d > error.html
echo "$CSS_CONTENT" | base64 -d > main.css
az storage blob upload-batch -s . -d '$web' --overwrite
'''
  }
}

output websiteEndpoint string = storageAccount.properties.primaryEndpoints.web
