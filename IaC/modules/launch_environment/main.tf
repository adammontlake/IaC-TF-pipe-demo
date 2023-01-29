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


module "storage_name" {
  source      = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/naming_convention"
  location    = var.location
  environment = var.environment
  servicename = "${var.environment}storage"
}

module "env_storage" {
  source               = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/storage"
  service_name            =local.service_name
  resource_group_name     =     azurerm_resource_group.env_rg.name
  location                =           var.location
  account_tier                  = local.account_tier
  environment             = var.environment
  terraform_state_storage = true
  secure_storage          = var.secure_storage
  tags = {
    environment = var.environment
    costcenter  = "it"
  }
}
