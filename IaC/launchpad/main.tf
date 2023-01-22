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
  # Comment
  # default values for setting up the environment
  module_tag = {
    "module"    = "launchpad"
    "managedby" = "terraform"
  }
  tags                  = merge(local.module_tag)
  location              = "eastus"
  environment_name_prod = "production"
  environment_name_stg  = "staging"
  service_name          = "terraform"
  location-int          = "eastus"
  environment-int       = "integration"
  service_name-int      = "terraform"
}

module "launch_prod" {
  source         = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/launch_environment"
  location       = local.location
  environment    = local.environment_name_prod
  secure_storage = true
}

module "launch_stage" {
  source         = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/launch_environment"
  location       = local.location
  environment    = local.environment_name_stg
  secure_storage = true
}