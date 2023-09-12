output "nsg_name" {
  value = zipmap(
    [for nsg in var.nsg : nsg.resource],
    values(azurerm_network_security_group.nsg)[*].name
  )
}

output "nsg_id" {
  value = zipmap(
    [for nsg in var.nsg : nsg.resource],
    values(azurerm_network_security_group.nsg)[*].id
  )
}
