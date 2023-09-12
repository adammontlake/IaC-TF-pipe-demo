locals {
  # A map of functions to generate the name based on the type
  name_functions = {
    resource_group                        = local.resource_group_name
    managed_identity                      = local.managed_identity_name
    virtual_network                       = local.virtual_network_name
    vpn_gateway                           = local.vpn_gateway_name
    vpn_gateway_s2s_connection            = local.vpn_gateway_s2s_connection_name
    vpn_gateway_er_connection             = local.vpn_gateway_er_connection_name
    subnet_network                        = local.subnet_network_name
    network_interface                     = local.network_interface_name
    public_ip_network                     = local.public_ip_network_name
    network_security_group                = local.network_security_group_name
    network_security_group_rule           = local.network_security_group_rule_name
    application_security_group            = local.application_security_group_name
    route_table                           = local.route_table_name
    key_vault                             = local.key_vault_name
    key_vault_key                         = local.key_vault_key_name
    key_vault_secret                      = local.key_vault_secret_name
    private_endpoint                      = local.private_endpoint_name
    storage_account                       = local.storage_account_name
    vnet_peering                          = local.vnet_peering_name
    vm                                    = local.vm_name
    vmss                                  = local.vmss_name
    firewall                              = local.firewall_name
    firewall_Policy                       = local.firewall_Policy_name
    firewall_policy_rule_collection_group = local.firewall_policy_rule_collection_group_name
    firewall_policy_rule_collection       = local.firewall_policy_rule_collection_name
    firewall_policy_rule_DNAT             = local.firewall_policy_rule_DNAT_name
    firewall_policy_rule_app              = local.firewall_policy_rule_app_name
    firewall_policy_rule_network          = local.firewall_policy_rule_network_name
    managed_disk                          = local.managed_disk_name
    disk_encryption_set                   = local.disk_encryption_set_name
    ssh_key                               = local.ssh_key_name
    dns_private_resolver                  = local.dns_private_resolver_name
    dns_private_resolver_endpoint         = local.dns_private_resolver_endpoint_name
    dns_private_resolver_rule_set         = local.dns_private_resolver_rule_set_name
    dns_private_resolver_rule_set_rule    = local.dns_private_resolver_rule_set_rule_name
  }
}
