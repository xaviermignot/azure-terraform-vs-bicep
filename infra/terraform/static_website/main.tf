resource "azurerm_storage_account" "account" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = substr("st${replace("${var.project}${var.unique_suffix}", "-", "")}", 0, 24)
  tags                = var.tags

  account_replication_type      = "LRS"
  account_tier                  = "Standard"
  public_network_access_enabled = true
  https_traffic_only_enabled    = true
  min_tls_version               = "TLS1_2"
}

resource "azurerm_storage_account_static_website" "static_website" {
  storage_account_id = azurerm_storage_account.account.id
  index_document     = "index.html"
  error_404_document = "error.html"
}

# resource "azurerm_storage_container" "some_container" {
#   storage_account_name = azurerm_storage_account.account.name
#   name                 = "some-container"
# }

resource "azurerm_storage_blob" "files" {
  for_each = toset(["index.html", "error.html", "main.css"])

  name                   = each.key
  storage_account_name   = azurerm_storage_account.account.name
  storage_container_name = "$web"

  type           = "Block"
  content_type   = "text/${split(".", each.key)[1]}; charset=utf-8"
  source_content = replace(file("../../src/${each.key}"), "##IAC_TOOL##", "Terraform 🚀")
}
