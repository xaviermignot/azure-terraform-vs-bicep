locals {
  tags = {
    project        = var.project
    deploymentMode = "Terraform"
    repository     = "azure-terraform-vs-bicep"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project}"
  location = var.location
  tags     = merge(local.tags, { module = "root" })
}

resource "random_pet" "pet" {}

module "static_website" {
  source = "./static_website"

  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  project             = var.project
  unique_suffix       = random_pet.pet.id
  tags                = merge(local.tags, { module = "static_website" })
}

module "is_even" {
  source   = "./is_even"
  for_each = toset(["1", "2", "3"])

  value = tonumber(each.key)
}

locals {
  is_even_results = [for value in ["1", "2", "3"] : {
    value = value
    result = module.is_even[value].result
  }]
}

output "is_even_results" {
  value = local.is_even_results
}
