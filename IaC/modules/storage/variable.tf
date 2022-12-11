variable "service_name" {
  description = "will be the name of the service, for example \"<env>-<service-name>-storage-<region>\""
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group where to create the resource."
  type        = string
}

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

variable "account_tier" {
  description = "The account_tier of the storage account. Accepted values are Basic and Standard. Defaults to Basic."
  type        = string
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard"], var.account_tier)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#account_tier."
  }
}

variable "tags" {
  description = "Tags for the resource to be deployed."
  default     = null
  type        = map(any)
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

variable "terraform_state_storage" {
  type        = bool
  description = "Define storage as dedicated for holoding Terraform state"
  default     = false
}