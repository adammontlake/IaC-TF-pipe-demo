locals {
  # default tags for the redis resource
  service_name   = "demoservice"
  account_tier   = "Standard"
  environment    = "production"
  fd_sku = "Premium_AzureFrontDoor"
  module_tag = {
    "managedby" = "terraform"
  }
  tags = merge(local.module_tag)
}

module "demo_resource_group" {
  #source        = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/resource_group"
  source      = "./../../modules/resource_group"
  providers   = { azurerm = azurerm.sub-dev }
  services    = ["rg-network"]
  environment = "production"
}

resource "azurerm_cdn_frontdoor_profile" "example" {
  name                = "example-cdn-profile"
  resource_group_name = module.demo_resource_group.rg_name["rg-network"]
  sku_name            = local.fd_sku

  tags = {
    environment = locals.environment
  }
}
