# generate the public ip name based on naming convention
module "pip_name" {
  source               = "git::https://github.com/microsoft/PDC//IaC/Modules/naming_convention"
  workload             = var.workload
  environment          = var.environment
  subscription_purpose = var.subscription_purpose
  type                 = "public_ip_network"
}

# create's the public ip
resource "azurerm_public_ip" "pip" {
  name                = module.pip_name.name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = var.zones

  lifecycle {
    ignore_changes = [tags]
  }
}
