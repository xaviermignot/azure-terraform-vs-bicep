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

// var numbers = [1, 2, 3]
// module isEven 'modules/isEven.bicep' = [for value in numbers: {
//   name: 'is-even-${value}'
//   params: {
//     value: value
//   }
// }]

// output isEvenResults array = [for (value, index) in numbers: {
//   value: value
//   isEven: isEven[index].outputs.result
// }]
