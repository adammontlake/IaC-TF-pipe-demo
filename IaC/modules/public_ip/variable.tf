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

variable "workload" {
  description = "(Required) Specifies the public ip's workload."
  type        = string
}

variable "rg_name" {
  description = "(Required) Specifies the public ip's resource group name."
  type        = string
}

variable "subscription_purpose" {
  description = "Specifies the pip connected resource subscription purpose."
  type        = string
}

variable "zones" {
  description = "Specifies the pip zones."
  type        = list(any)
  default     = null
}
