variable "servicename" {
  description = "(Required) Specifies the name of the service which will be created."
  type        = string
}

variable "environment" {
  description = "(Required) Specifies the environment, for example: 'production' or 'staging'"
  type        = string
  validation {
    condition     = contains(["production", "staging", "integration"], var.environment)
    error_message = "The environment value must be one of production, staging, integration in lower case."
  }
}

variable "location" {
  description = "(Required) Specifies the location, for example: 'north Europe' or 'west Europe'."
  type        = string
}
