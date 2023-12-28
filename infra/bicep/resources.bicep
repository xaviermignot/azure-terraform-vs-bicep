param location string
param project string
param uniqueSuffix string
param tags { *: string }

module storageAccount 'modules/storageAccount.bicep' = {
  name: '${deployment().name}-storage-account'
  params: {
    location: location
    tags: union(tags, { module: 'storageAccount.bicep' })
    project: project
    uniqueSuffix: uniqueSuffix
  }
}

module staticWebsite 'modules/staticWebsite.bicep' = {
  name: '${deployment().name}-static-website'
  params: {
    location: location
    project: project
    storageAccountName: storageAccount.outputs.storageAccountName
    tags: union(tags, { module: 'staticWebsite.bicep' })
  }
}

output websiteEndpoint string = staticWebsite.outputs.websiteEndpoint