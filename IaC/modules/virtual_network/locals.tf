locals {
  vnets = flatten([
    for vnet_key, vnet in var.virtual_networks : [
      for snet_key, snet in vnet.subnets : {
        vnet_key         = vnet_key
        snet_key         = snet_key
        workload         = snet.workload
        address_space    = snet.address_space
        nsg_id           = snet.nsg_id
        is_resolver_snet = snet.is_resolver_snet
      }
    ]
  ])
}
