output "id" {
  description = "The storage account ID"
  value       = azurerm_storage_account.storage.id
}

output "name" {
  description = "Storage account name"
  value       = azurerm_storage_account.storage.name
}