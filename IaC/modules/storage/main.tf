# Calling the naming module
module "storage_naming" {
  source      = "git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/naming_convention"
  location    = var.location
  environment = var.environment
  servicename = "${var.service_name}storage"
}

resource "azurerm_storage_account" "storage" {
  name                      = module.storage_naming.name_alphanum
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = var.account_tier       #validate the accoutn  tier in input
  account_replication_type  = local.replication_type #Determine replication type from environment
  enable_https_traffic_only = var.secure_storage
  tags                      = local.tags
}

resource "azurerm_storage_container" "terraform_state_storage" {
  count                 = var.terraform_state_storage ? 1 : 0 #Create this container if this storage will be used for storing terraform state
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}