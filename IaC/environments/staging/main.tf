terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.30.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "stg-staging-rg-e"
    storage_account_name = "stgterraformstoragee"
    container_name       = "tfstate"
    key                  = "stage.tfstate"
  }
}

<<<<<<< HEAD
provider "azurerm" {
  features {}
}

=======
# provider "azurerm" {
#   features {}
# }
>>>>>>> 5a644b8247576356749c75a2b5e64609f60312b6
