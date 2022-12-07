variable "environment" {
  description = "(Required) Name of the destination enviroment."
  type        = string
  default     = "dev"
  validation {
    condition = anytrue([
      var.environment == "integration",
      var.environment == "staging",
      var.environment == "prodtesting",
      var.environment == "production"
    ])
    error_message = "Environment  must be one of: \"int\", \"stg\", \"pp\" or \"prod\"."
  }
}

variable "resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type        = string
}

variable "location" {
  description = "The location of the vnet to be created."
  type        = string
}