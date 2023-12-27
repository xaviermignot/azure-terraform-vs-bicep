output "website_url" {
  value       = azurerm_storage_account.account.primary_web_endpoint
  description = "The URL of the static website."
}
