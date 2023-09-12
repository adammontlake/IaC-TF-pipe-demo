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

variable "pe_snet_id" {
  description = "(Required) Specifies the storage account's private endpoint subnet id."
  type        = string
}

variable "pe_zone_id" {
  description = "(Required) Specifies the storage account's private endpoint private DNS zone id."
  type        = string
}

variable "storage_accounts" {
  description = "(Required)Specifies the list of storage account's objects"
  type = list(object({
    description       = string
    rg_name           = string
    account_tier      = optional(string, "Standard")
    replication       = optional(string, "LRS")
    public_access     = optional(bool, true)
    encrypt_infra     = optional(bool, true)
    public_nested     = optional(bool, false)
    shared_access_key = optional(bool, true)
    delete_retention  = number
    restore           = number
    allowed_pips      = optional(list(string), [])
    allowed_snet_ids  = optional(list(string), [])
    containers        = list(string)
    kv_id             = string
    kv_key_name       = string
  }))
}
