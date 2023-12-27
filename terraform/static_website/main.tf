resource "azurerm_storage_account" "account" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = substr("st${replace("${var.project}${var.unique_suffix}", "-", "")}", 0, 24)
  tags                = var.tags

  account_replication_type      = "LRS"
  account_tier                  = "Standard"
  public_network_access_enabled = true
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"

  static_website {
    index_document     = "index.html"
    error_404_document = "error.html"
  }
}

resource "azurerm_storage_blob" "files" {
  for_each = toset(["index.html", "error.html", "main.css"])

  name                   = each.key
  storage_account_name   = azurerm_storage_account.account.name
  storage_container_name = "$web"

  type         = "Block"
  content_type = "text/${split(".", each.key)[1]}; charset=utf-8"
  source       = "src/${each.key}"
}
