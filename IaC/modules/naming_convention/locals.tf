locals {
  # create short location naming conventaion 
  location_short = substr(lower(join("", regexall("[A-Z]+", title(var.location)))), 0, 2)
  env            = var.environment == "production" ? "prod" : var.environment == "staging" ? "stg" : var.environment == "integration" ? "int" : var.environment == "pci" ? "pci" : var.environment == "prodtesting" ? "test" : var.environment == "preprod" ? "pp" : ""
}