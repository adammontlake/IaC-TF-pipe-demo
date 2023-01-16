output "rg_id" {
  description = "The resource group ID"
  value       = azurerm_resource_group.env_rg.id
}

output "rg_name" {
  description = "Storage resource group name"
  value       = azurerm_resource_group.env_rg.name
}

output "storage_id" {
  description = "The storage account ID"
  value       = azurerm_storage_account.env_storage.id
}

output "storage_name" {
  description = "Storage account name"
  value       = azurerm_storage_account.env_storage.name
}
