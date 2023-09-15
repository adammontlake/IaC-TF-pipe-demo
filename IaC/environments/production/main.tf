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