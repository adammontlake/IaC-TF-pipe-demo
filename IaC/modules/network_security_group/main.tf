# generate the network security group's name based on naming convention
module "nsg_name" {
  #source       = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/naming_convention"
  source       = "./../naming_convention"
  for_each     = { for idx, nsg in var.nsg : idx => nsg }
  environment  = var.environment
  nsg_scope    = each.value.scope
  nsg_resource = each.value.resource
  type         = "network_security_group"
}

# create's network security group
resource "azurerm_network_security_group" "nsg" {
  for_each            = { for idx, nsg in var.nsg : idx => nsg }
  name                = module.nsg_name[each.key].name
  location            = var.location
  resource_group_name = each.value.rg_name

  lifecycle {
    ignore_changes = [tags]
  }
}

# create's network security group's default Inbound deny rule
resource "azurerm_network_security_rule" "deny_all_in" {
  for_each                    = { for idx, nsg in var.nsg : idx => nsg if nsg.add_default_deny_all_in_rule == true }
  network_security_group_name = module.nsg_name[each.key].name
  resource_group_name         = each.value.rg_name
  name                        = "default-deny-all-in"
  description                 = "default-deny-all"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  access                      = "Deny"
  priority                    = 4096
  direction                   = "Inbound"
  depends_on                  = [azurerm_network_security_group.nsg]
}

# create's network security group's default Outbound deny rule
resource "azurerm_network_security_rule" "deny_all_out" {
  for_each                    = { for idx, nsg in var.nsg : idx => nsg if nsg.add_default_deny_all_out_rule == true }
  network_security_group_name = module.nsg_name[each.key].name
  resource_group_name         = each.value.rg_name
  name                        = "default-deny-all-out"
  description                 = "default-deny-all"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  access                      = "Deny"
  priority                    = 4096
  direction                   = "Outbound"
  depends_on                  = [azurerm_network_security_group.nsg]
}
