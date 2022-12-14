# Azure Generic VNet Module

module "naming" {
  source      = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/naming_convention"
  location    = var.location
  environment = var.environment
  servicename = "${var.service_name}-vnet"
}

resource "azurerm_virtual_network" "vnet" {
  name                = module.naming.full_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = length(var.address_spaces) == 0 ? [var.address_space] : var.address_spaces
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each                                       = toset(var.subnet_names)
  name                                           = each.value
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = [var.subnet_prefixes[index(var.subnet_names, each.value)]]
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = lookup(var.subnet_enforce_private_link_endpoint_network_policies, each.value, false)
  service_endpoints                              = lookup(var.subnet_service_endpoints, each.value, [])
}