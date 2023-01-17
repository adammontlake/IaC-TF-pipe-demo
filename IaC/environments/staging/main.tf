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