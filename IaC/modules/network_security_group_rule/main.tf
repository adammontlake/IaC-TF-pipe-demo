# generate the network security group's rules name based on naming convention
module "nsg_name" {
  source               = "git::https://github.com/microsoft/PDC//IaC/Modules/naming_convention"
  for_each             = { for idx, rule in var.nsg_rules : idx => rule }
  environment          = var.environment
  direction            = each.value.direction
  action               = lower(each.value.action)
  traffic_protocol     = lower(each.value.protocol)
  destination_port     = each.value.dest_port != "*" ? each.value.dest_port : each.value.src_port
  source_resource      = each.value.source_resource
  destination_resource = each.value.destination_resource
  type                 = "network_security_group_rule"
}

# create's network security group's rules
resource "azurerm_network_security_rule" "rule" {
  for_each                                   = { for idx, rule in var.nsg_rules : idx => rule }
  network_security_group_name                = each.value.nsg_name
  resource_group_name                        = each.value.nsg_rg_name
  name                                       = module.nsg_name[each.key].name
  description                                = each.value.description
  protocol                                   = each.value.protocol
  source_port_range                          = each.value.src_port
  destination_port_range                     = each.value.dest_port
  source_address_prefix                      = each.value.src_address
  source_application_security_group_ids      = each.value.src_asg_ids
  destination_address_prefix                 = each.value.dest_address
  destination_application_security_group_ids = each.value.dest_asg_ids
  access                                     = each.value.action
  priority                                   = each.value.priority
  direction                                  = each.value.direction == "i" ? "Inbound" : "Outbound"
}

