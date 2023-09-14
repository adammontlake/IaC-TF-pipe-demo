# generate the resource group's name based on naming convention
module "rg_name" {
  source       = "git::https://github.com/adammontlake/IaC-TF-pipe-demo//IaC/modules/naming_convention"
  for_each     = { for idx, rg in var.services : idx => rg }
  service_name = each.value
  environment  = var.environment
  type         = "resource_group"
}

# create's resource groups
resource "azurerm_resource_group" "rg" {
  for_each = { for idx, rg in var.services : idx => rg }
  name     = module.rg_name[each.key].name
  location = var.location

  lifecycle {
    ignore_changes = [tags]
  }
}
