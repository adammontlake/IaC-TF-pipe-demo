variable "environment" {
  description = "(Required) Specifies the environment, for example: 'production' or 'pre-production'"
  type        = string
  validation {
    condition     = contains(["production", "pre-production", "development"], var.environment)
    error_message = "The environment value must be one of production, development, pre-production in lower case."
  }
}

variable "location" {
  description = "(Optional) Specifies the location, for example: 'north Europe' or 'west Europe'."
  type        = string
  default     = "West Europe"
}

variable "services" {
  description = "(Required) Specifies the list of resource group's service name"
  type        = list(string)
}
