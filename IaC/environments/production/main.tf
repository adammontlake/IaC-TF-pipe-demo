locals {
  # default tags for the redis resource
  service_name   = "demoservice"
  account_tier   = "Standard"
  environment    = "production"
  secure_storage = true
  module_tag = {
    "managedby" = "terraform"
  }
  tags = merge(local.module_tag)
}

module "demo_resource_group" {
  #source        = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/resource_group"
  source      = "./../../modules/resource_group"
  providers   = { azurerm = azurerm.sub-dev }
  services    = ["rg-network", "rg-storage", "rg-firewall", "rg-keyvault"]
  environment = "production"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}