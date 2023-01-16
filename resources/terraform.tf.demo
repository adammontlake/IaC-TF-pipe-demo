terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.30.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg_tf_launchpad"
    storage_account_name = "storagetflaunchpad"
    container_name       = "tfstate"
    key                  = "launchpad.tfstate"
  }
}

provider "azurerm" {
  features {}
}

locals {
  # default values for setting up the environment
  module_tag = {
    "module"    = "launchpad"
    "managedby" = "terraform"
  }
  tags             = merge(local.module_tag)
  location         = "eastus"
  environment      = "production"
  service_name     = "terraform"
  location-int     = "eastus"
  environment-int  = "integration"
  service_name-int = "terraform"
}


module "storage_module" {
  source                  = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/storage"
  service_name            = "terraform"
  resource_group_name     = module.prod_rg_name.full_name
  location                = local.location
  account_tier            = "Standard"
  environment             = local.environment
  terraform_state_storage = true
  tags = {
    environment = "production"
    costcenter  = "it"
  }
}
