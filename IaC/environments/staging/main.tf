locals {
  # default tags for the redis resource
  service_name   = "demoservice"
  account_tier   = "Standard"
  environment    = "staging"
  secure_storage = true
  module_tag = {
    "managedby" = "terraform"
  }
  tags = merge(local.module_tag)
}