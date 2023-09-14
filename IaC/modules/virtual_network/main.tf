# generate the virtual network name based on naming convention
module "vnet_name" {
  #source      = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/naming_convention"
  source      = "./../naming_convention"
  for_each    = { for idx, vnet in var.virtual_networks : idx => vnet }
  workload    = each.value.workload
  environment = var.environment
  type        = "virtual_network"
}

# create's virtual networks
resource "azurerm_virtual_network" "vnet" {
  for_each            = { for idx, vnet in var.virtual_networks : idx => vnet }
  name                = module.vnet_name[each.key].name
  resource_group_name = each.value.rg_name
  location            = var.location
  address_space       = [each.value.address_space]
  dns_servers         = each.value.dns_servers

  lifecycle {
    ignore_changes = [tags]
  }
}

# generate the virtual network's subnets names based on naming convention
module "snet_names" {
  #source      = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/naming_convention"
  source      = "./../naming_convention"
  for_each    = { for snet in local.vnets : "${snet.vnet_key}.${snet.snet_key}" => snet }
  workload    = each.value.workload
  environment = var.environment
  type        = "subnet_network"
}

# create's the virtual network's subnets
resource "azurerm_subnet" "subnet" {
  for_each                                      = { for snet in local.vnets : "${snet.vnet_key}.${snet.snet_key}" => snet }
  name                                          = module.snet_names[each.key].name
  resource_group_name                           = azurerm_virtual_network.vnet[each.value.vnet_key].resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet[each.value.vnet_key].name
  address_prefixes                              = [each.value.address_space]
  private_link_service_network_policies_enabled = false

  dynamic "delegation" {
    for_each = each.value.is_resolver_snet == true ? [1] : []
    content {
      name = "delegation"
      service_delegation {
        name    = "Microsoft.Network/dnsResolvers"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }
  }
}

# create's subnet's network security group association
resource "azurerm_subnet_network_security_group_association" "association" {
  for_each                  = { for idx, snet in local.vnets : "${snet.vnet_key}.${snet.snet_key}" => snet if snet.workload != "GatewaySubnet" && snet.workload != "AzureFirewallSubnet" }
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = each.value.nsg_id
}
