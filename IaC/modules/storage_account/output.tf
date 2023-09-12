output "storage_name" {
  value = zipmap(
    [for storage in var.storage_accounts : storage.description],
    values(azurerm_storage_account.storage_account)[*].name
  )
}

output "storage_id" {
  value = zipmap(
    [for storage in var.storage_accounts : storage.description],
    values(azurerm_storage_account.storage_account)[*].id
  )
}

output "container_id" {
  value = zipmap(
    flatten([for storage in var.storage_accounts : [for container in storage.containers : container]]),
    values(azurerm_storage_container.storage_container)[*].id
  )
}

output "container_mane" {
  value = zipmap(
    flatten([for storage in var.storage_accounts : [for container in storage.containers : container]]),
    values(azurerm_storage_container.storage_container)[*].name
  )
}

output "storage_pe_name" {
  value = zipmap(
    [for storage in var.storage_accounts : storage.description],
    [for key, storage in azurerm_storage_account.storage_account : module.private_endpoint[key].pe_name]
  )
}

output "storage_pe_id" {
  value = zipmap(
    [for storage in var.storage_accounts : storage.description],
    [for key, storage in azurerm_storage_account.storage_account : module.private_endpoint[key].pe_id]
  )
}

output "storage_pe_ip" {
  value = zipmap(
    [for storage in var.storage_accounts : storage.description],
    [for key, storage in azurerm_storage_account.storage_account : module.private_endpoint[key].pe_ip]
  )
}
