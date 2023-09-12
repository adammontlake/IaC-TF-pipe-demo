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

variable "nsg" {
  description = "(Required) Specifies the network security group's object."
  type = list(object({
    scope                         = string
    resource                      = string
    rg_name                       = string
    add_default_deny_all_in_rule  = optional(bool, false)
    add_default_deny_all_out_rule = optional(bool, false)
  }))

  validation {
    condition     = alltrue([for nsg in var.nsg : contains(["subnet", "network_interface"], nsg.scope)])
    error_message = "The scope value must be one of subnet or network_interface in lower case."
  }
}
