locals {
  # default tags for the redis resource
  account_tier = "Standard"
  service_name = "terraform"
  module_tag = {
    "module"    = basename(abspath(path.module))
    "managedby" = "terraform"
  }
  tags = merge(local.module_tag)
}