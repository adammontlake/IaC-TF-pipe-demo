output "rg_name" {
  value = zipmap(
    [for rg in var.services : rg],
    values(azurerm_resource_group.rg)[*].name
  )
}

output "rg_id" {
  value = zipmap(
    [for rg in var.services : rg],
    values(azurerm_resource_group.rg)[*].id
  )
}
