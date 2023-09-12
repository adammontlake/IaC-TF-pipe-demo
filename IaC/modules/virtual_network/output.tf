output "vnet_name" {
  value = zipmap(
    [for vnet in var.virtual_networks : vnet.workload],
    values(azurerm_virtual_network.vnet)[*].name
  )
}

output "vnet_id" {
  value = zipmap(
    [for vnet in var.virtual_networks : vnet.workload],
    values(azurerm_virtual_network.vnet)[*].id
  )
}

output "snet_name" {
  value = zipmap(
    flatten([for vnet in var.virtual_networks : [for subnet in vnet.subnets : subnet.workload]]),
    values(azurerm_subnet.subnet)[*].name
  )
}

output "snet_id" {
  value = zipmap(
    flatten([for vnet in var.virtual_networks : [for subnet in vnet.subnets : subnet.workload]]),
    values(azurerm_subnet.subnet)[*].id
  )
}
