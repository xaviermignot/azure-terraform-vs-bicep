param location string
param project string
param uniqueSuffix string
param tags { *: string }

var containerName = 'tfstate'
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
#disable-next-line BCP334
  name: take(replace('st${project}${uniqueSuffix}', '-', ''), 24)
  location: location
  tags: tags

  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'

  resource blobService 'blobServices' = {
    name: 'default'

    resource stateContainer 'containers' = {
      name: containerName
    }
  }
}

output storageAccountName string = storageAccount.name
output containerName string = containerName
