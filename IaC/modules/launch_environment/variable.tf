
variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
  validation {
    condition = anytrue([
      var.location == "eastus",
      var.location == "eastus2",
      var.location == "westus"
    ])
    error_message = "location  must be one of: \"eastus\", \"eastus2\" or \"westus\"."
  }
}

variable "environment" {
  description = "Name of the destination enviroment."
  type        = string
  default     = "production"
  validation {
    condition = anytrue([
      var.environment == "integration",
      var.environment == "staging",
      var.environment == "production"
    ])
    error_message = "Environment  must be one of: \"integration\", \"staging\" or \"production\"."
  }
}

variable "secure_storage" {
  type        = bool
  description = "Define a storage account that disables the https_traffic_only flag, defaults to true"
  default     = true
}