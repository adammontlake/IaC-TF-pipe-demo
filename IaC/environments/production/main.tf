locals {
  env    = "production"
  eh_sku = "Premium"
}

# module "demo_resource_group" {
#   source      = "./../../modules/resource_group"
#   providers   = { azurerm = azurerm.sub-dev }
#   services    = ["network"]
#   environment = local.env
# }

# resource "azurerm_eventhub_namespace" "example" {
#   name                = "example-eh"
#   location            = module.demo_resource_group.rg_location["network"]
#   resource_group_name = module.demo_resource_group.rg_name["network"]
#   sku                 = local.eh_sku
#   capacity            = 1
# }
