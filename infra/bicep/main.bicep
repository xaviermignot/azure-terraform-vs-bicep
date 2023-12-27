targetScope = 'subscription'

param location string

var project = 'tf-vs-bicep'
var uniqueSuffix = uniqueString(subscription().id, project)

var tags = {
  project: project
  deploymentMode: 'Bicep'
  repository: 'azure-terraform-vs-bicep'
}

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-${project}'
  location: location
  tags: union(tags, { module: 'main.bicep' })
}

module resources 'resources.bicep' = {
  name: '${deployment().name}-resources'
  scope: rg
  params: {
    location: location
    tags: union(tags, { module: 'resources.bicep' })
    project: project
    uniqueSuffix: uniqueSuffix
  }
}

output websiteEndpoint string = resources.outputs.websiteEndpoint
