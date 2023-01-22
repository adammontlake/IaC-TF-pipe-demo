terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.30.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  environment              = "production"
  service_name             = "terraform"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "random_string" "random_suffix" {
  length  = 4
  special = false
  upper   = false
}

data "azurerm_resource_group" "rg" {
  name = "IaC_pipelines_rg"
}

# Storage account with website (From Itamar)
resource "azurerm_storage_account" "example-sa" {
  name                     = "websitestorage${random_string.random_suffix.result}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = local.account_tier
  account_replication_type = local.account_replication_type

  tags = {
    environment = "test"
  }
}

resource "azurerm_storage_container" "websitecontainer" {
  name                  = "sitecontainer"
  storage_account_name  = azurerm_storage_account.example-sa.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "content" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.example-sa.name
  storage_container_name = azurerm_storage_container.websitecontainer.name
  type                   = "Block"
  source                 = "index.html"
  content_type           = "text/html"
}

output "site_address" {
  value = azurerm_storage_blob.content.url
}
