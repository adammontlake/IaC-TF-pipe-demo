# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "= 3.30.0"
#     }
#   }
#   backend "azurerm" {
#     resource_group_name  = "prod-production-rg-e"
#     storage_account_name = "prodterraformstorageeiac"
#     container_name       = "tfstate"
#     key                  = "production.tfstate"
#   }
# }