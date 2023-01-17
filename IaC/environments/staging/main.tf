terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.30.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "stg-terraform-rg-e"
    storage_account_name = "stgterraformstoragee"
    container_name       = "tfstate"
    key                  = "stage.tfstate"
  }
}

provider "azurerm" {
  features {}
}

