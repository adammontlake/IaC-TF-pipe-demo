locals {
  # default tags for the redis resource
  service_name   = "demoservice"
  account_tier   = "Standard"
  environment    = "production"
  secure_storage = true
  module_tag = {
    "managedby" = "terraform"
  }
  tags = merge(local.module_tag)
}

module "demo_resource_group" {
  #source        = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/resource_group"
  source      = "./../../modules/resource_group"
  providers   = { azurerm = azurerm.sub-dev }
  services    = ["rg-network", "rg-storage", "rg-firewall", "rg-keyvault"]
  environment = "production"
}

module "network_security_group" {
  source      = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/network_security_group"
  providers   = { azurerm = azurerm.sub-dev }
  environment = "production"
  nsg = [
    {
      scope                         = "subnet"
      resource                      = "vm"
      rg_name                       = module.demo_resource_group.rg_name["rg-network"]
      add_default_deny_all_in_rule  = false
      add_default_deny_all_out_rule = false
    },
    {
      scope                         = "subnet"
      resource                      = "vm2"
      rg_name                       = module.demo_resource_group.rg_name["rg-network"]
      add_default_deny_all_in_rule  = false
      add_default_deny_all_out_rule = false
    }
  ]
}

module "virtual_network" {
  source      = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/virtual_network"
  providers   = { azurerm = azurerm.sub-dev }
  environment = "production"
  virtual_networks = [
    {
      workload      = "demo_resources"
      rg_name       = module.demo_resource_group.rg_name["rg-network"]
      address_space = "10.0.0.0/24"
      subnets = [
        {
          workload      = "vm"
          address_space = "10.0.0.64/28"
          nsg_id        = module.network_security_group.nsg_id["vm1"]
        },
        {
          workload      = "vm2"
          address_space = "10.0.0.128/26"
          nsg_id        = module.network_security_group.nsg_id["vm2"]
        }
      ]
    }
  ]
}