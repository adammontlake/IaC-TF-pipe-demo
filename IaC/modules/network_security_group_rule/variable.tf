variable "environment" {
  description = "(Required) Specifies the environment, for example: 'production' or 'pre-production'"
  type        = string
  validation {
    condition     = contains(["production", "pre-production", "development"], var.environment)
    error_message = "The environment value must be one of production, development, pre-production in lower case."
  }
}

variable "nsg_rules" {
  description = "(Required) Specifies the network security group's rules objects."
  type = list(object({
    nsg_name             = string
    nsg_rg_name          = string
    direction            = optional(string, "i")
    action               = optional(string, "Allow")
    source_resource      = string
    destination_resource = string
    description          = optional(string, "DESC")
    protocol             = optional(string, "*")
    src_port             = optional(string, "*")
    dest_port            = optional(string, "*")
    src_address          = optional(string, null)
    src_asg_ids          = optional(list(string), null)
    dest_address         = optional(string, null)
    dest_asg_ids         = optional(list(string), null)
    priority             = number
  }))

  validation {
    condition     = alltrue([for rule in var.nsg_rules : contains(["Tcp", "Udp", "Icmp", "Esp", "Ah", "*"], rule.protocol)])
    error_message = "The protocol value must be one of Tcp, Udp, Icmp, Esp, Ah or *."
  }

  validation {
    condition     = alltrue([for rule in var.nsg_rules : contains(["Allow", "Deny"], rule.action)])
    error_message = "The action value must be one of Allow or Deny."
  }
}
