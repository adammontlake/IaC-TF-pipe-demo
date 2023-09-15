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

variable "virtual_networks" {
  description = "(Required)Specifies the virtual network's objects with its subnets"
  type = list(object({
    workload      = string
    rg_name       = string
    address_space = string
    dns_servers   = optional(list(string), [])
    subnets = list(object({
      workload         = string
      address_space    = string
      nsg_id           = optional(string, null)
      is_resolver_snet = optional(bool, false)
    }))
  }))
}
