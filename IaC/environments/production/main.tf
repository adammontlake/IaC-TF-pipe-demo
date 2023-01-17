# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "= 3.30.0"
#     }
#   }
#   backend "azurerm" {
#     resource_group_name  = "prod-terraform-rg-e"
#     storage_account_name = "prodterraformstoragee"
#     container_name       = "tfstate"
#     key                  = "production.tfstate"
#   }
# }

# provider "azurerm" {
#   features {}
# }
