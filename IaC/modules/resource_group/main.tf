# Calling the naming module
module "rg_name" {
  source      = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/naming_convention"
  location    = var.location
  environment = var.environment
  servicename = "${var.environment}-rg"
}

resource "azurerm_resource_group" "env_rg" {
  name     = module.rg_name.full_name
  location = var.location
  tags = {
    environment = var.environment
    costcenter  = "it"
  }
}