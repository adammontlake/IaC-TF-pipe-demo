locals {
  # default tags for the redis resource
  module_tag = {
    "module"    = basename(abspath(path.module))
    "managedby" = "terraform"
  }
  tags = merge(local.module_tag)
}