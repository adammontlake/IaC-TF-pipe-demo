terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.30.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "stg-staging-rg-e"
    storage_account_name = "stgterraformstorageeiac"
    container_name       = "tfstate"
    key                  = "stage.tfstate"
  }
}

provider "azurerm" {
  features {}
}

locals {
  # default tags for the redis resource
  service_name = "demoservice"
  account_tier = "Standard"
  environment = "staging"
  secure_storage = false
  module_tag = {
    "managedby" = "terraform"
  }
  tags             = merge(local.module_tag)
}

data "azurerm_resource_group" "staging_resource_group" {
      name = "stg-staging-rg-e"
}

module "staging_storage" {
  source                  = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/storage"
  service_name            = local.service_name
  resource_group_name     = data.azurerm_resource_group.staging_resource_group.name
  location                = data.azurerm_resource_group.staging_resource_group.location
  account_tier            = local.account_tier
  environment             = local.environment
  secure_storage          = local.secure_storage
  tags = {
    environment = local.environment
    costcenter  = "it"
  }
}
