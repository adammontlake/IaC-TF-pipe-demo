locals {
  # Comment
  # default values for setting up the environment
  module_tag = {
    "module"    = "launchpad"
    "managedby" = "terraform"
  }
  tags                  = merge(local.module_tag)
  location              = "eastus"
  environment_name_prod = "production"
  environment_name_stg  = "staging"
  service_name          = "terraform"
  location-int          = "eastus"
  environment-int       = "integration"
  service_name-int      = "terraform"
}