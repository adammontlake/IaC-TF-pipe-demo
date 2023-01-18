output "rg_id" {
  description = "The resource group ID"
  value       = azurerm_resource_group.env_rg.id
}

output "rg_name" {
  description = "The resource group name"
  value       = azurerm_resource_group.env_rg.name
}

output "rg_location" {
  description = "The resource group location"
  value       = azurerm_resource_group.env_rg.location
}