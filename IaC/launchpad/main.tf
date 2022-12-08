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
  tags               = merge(local.module_tag)
  location           = "eastus"
  environment        = "production"
  service_name       = "terraform"
  location-stage     = "eastus2"
  environment-stage  = "staging"
  service_name-stage = "terraform"
}

module "prod_rg_name" {
  source      = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/naming_convention"
  location    = local.location
  environment = local.environment
  servicename = "${local.service_name}-rg"
}

resource "azurerm_resource_group" "production_rg" {
  name     = module.prod_rg_name.full_name
  location = local.location
}

module "stage_rg_name" {
  source      = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/naming_convention"
  location    = local.location-stage
  environment = local.environment-stage
  servicename = "${local.service_name-stage}-rg"
}
