variable "nsg_resource" {
  description = "Specifies the resource type for which the NSG is created."
  type        = string
  default     = ""
}

variable "nsg_scope" {
  description = "Specifies the scope for which the NSG is created."
  type        = string
  validation {
    condition     = contains(["subnet", "network_interface"], var.nsg_scope)
    error_message = "The nsg_scope value must be one of subnet or network_interface in lower case."
  }
  default = "subnet"
}

variable "workload" {
  description = "Specifies the name of the service which will be created."
  type        = string
  default     = ""
}

variable "resource_number" {
  description = "Specifies the number (in order) of the service which will be created."
  type        = string
  default     = ""
}

variable "service_name" {
  description = "Specifies the name of the service which will be created."
  type        = string
  default     = ""
}

variable "environment" {
  description = "Specifies the environment, for example: 'production' or 'staging'"
  type        = string
  validation {
    condition     = contains(["production", "development", "pre-production"], var.environment)
    error_message = "The environment value must be one of production, development, pre-production in lower case."
  }
  default = ""
}

variable "type" {
  description = "[Mandatory] Specifies the type of the resource in lower case, for example: 'resource_group' or 'subnet'."
  type        = string
  validation {
    condition = contains([
      "resource_group", "managed_identity", "virtual_network", "vpn_gateway", "managed_disk", "ssh_key",
      "subnet_network", "network_interface", "public_ip_network",
      "network_security_group", "network_security_group_rule", "application_security_group", "route_table",
      "key_vault", "private_endpoint", "storage_account", "vnet_peering", "vm", "vmss",
      "firewall", "firewall_Policy", "firewall_policy_rule_collection_group",
      "firewall_policy_rule_collection", "firewall_policy_rule_DNAT", "firewall_policy_rule_app",
      "firewall_policy_rule_network", "dns_private_resolver", "dns_private_resolver_endpoint",
      "dns_private_resolver_rule_set", "dns_private_resolver_rule_set_rule",
      "disk_encryption_set", "key_vault_key", "key_vault_secret", "vpn_gateway_s2s_connection", "vpn_gateway_er_connection",
    ], var.type)
    error_message = "The type value was not recognized as a supported resource type, either correct the type or add support for this resource in the module."
  }
}

variable "subnet_name" {
  description = "Specifies the name of the subnet that the resource will be associated to."
  type        = string
  default     = ""
}

variable "subscrtiption_name" {
  description = "Specifies the name of the subscription, for example: 'sub-sentinel-pron' or 'sub-dev'"
  type        = string
  validation {
    condition = contains([
      "sub-management-platform", "sub-shared_resources-platform", "sub-sentinel-prod", "sub-workspace-prod", "sub-sentinel-pre_prod", "sub-workspace-pre_prod", "sub-dev", ""
    ], var.subscrtiption_name)
    error_message = "The subscrtiption name value must be in lower case and from one of the pre-approved subscriptions for deployment."
  }
  default = ""
}

variable "storage_description" {
  description = "Specifies the name of the subnet that the resource will be associated to."
  type        = string
  default     = ""
}

variable "source_network" {
  description = "Specifies the name of the source virtual network for the peering association."
  type        = string
  default     = ""
}

variable "target_network" {
  description = "Specifies the name of the target virtual network for the peering association."
  type        = string
  default     = ""
}

variable "number" {
  description = "Specifies the number of the resource being created, defaults to 1."
  type        = number
  default     = 1
}

variable "traffic_type" {
  description = "Specifies the type of the traffic this resource relates to, can be: application, network or DNAT."
  type        = string
  validation {
    condition     = contains(["application", "network", "DNAT"], var.traffic_type)
    error_message = "The type value must be one of application, network or DNAT."
  }
  default = "network"
}

variable "policy_description" {
  description = "Specifies the description of the firewall policy."
  type        = string
  default     = ""
}

variable "group_description" {
  description = "Specifies the description of the firewall rule group."
  type        = string
  default     = ""
}

variable "source_address_title" {
  description = "Describes the source of the traffic."
  type        = string
  default     = ""
}

variable "source_port" {
  description = "Source port for the traffic."
  type        = string
  default     = ""
}

variable "traffic_protocol" {
  description = "Specifies the protocol of the traffic this rule relates to, can be: tcp, udp or icmp."
  type        = string
  validation {
    condition     = contains(["tcp", "udp", "icmp"], var.traffic_protocol)
    error_message = "The type value must be one of tcp, udp or icmp."
  }
  default = "tcp"
}

variable "desatination_address_title" {
  description = "Describes the destination of the traffic."
  type        = string
  default     = ""
}

variable "destination_port" {
  description = "Destination port for the traffic."
  type        = string
  default     = ""
}

variable "disk_resource_description" {
  description = "Disc resource description."
  type        = string
  default     = ""
}

variable "disk_description" {
  description = "Specifies what the storage will be used for."
  type        = string
  validation {
    condition     = contains(["os", "data"], var.disk_description)
    error_message = "The description must be os or data."
  }
  default = "os"
}

variable "ssh_key_usage" {
  description = "Specifies the ssh key usage."
  type        = string
  default     = "access"
}

variable "direction" {
  description = "Specifies the DNS private resolver endpoint direction"
  type        = string
  default     = "in"
}

variable "rule_set_description" {
  description = "Specifies the DNS private resolver rule set description"
  type        = string
  default     = ""
}

variable "destination_description" {
  description = "Specifies the DNS private resolver rule set rule destination description"
  type        = string
  default     = ""
}

variable "des_usage" {
  description = "Specifies the disk encryption set usage."
  type        = string
  validation {
    condition     = contains(["os", "data"], var.des_usage)
    error_message = "The des_usage value must be one of os or data."
  }
  default = "os"
}

variable "usage" {
  description = "Specifies the key vault key or secret usage."
  type        = string
  default     = ""
}

variable "action" {
  description = "Specifies the nsg rule action type."
  type        = string
  validation {
    condition     = contains(["allow", "deny"], var.action)
    error_message = "The action value must be one of allow or deny."
  }
  default = "allow"
}

variable "source_resource" {
  description = "Specifies the nsg rule source resource."
  type        = string
  default     = ""
}

variable "destination_resource" {
  description = "Specifies the nsg rule destination resource."
  type        = string
  default     = "allow"
}

variable "subscription_purpose" {
  description = "Specifies the vpn gateway subscription purpose."
  type        = string
  default     = ""
}

variable "vnet_purpose" {
  description = "Specifies the vpn gateway vnet purpose."
  type        = string
  default     = ""
}

variable "vpn_type" {
  description = "Specifies the vpn gateway type."
  type        = string
  validation {
    condition     = contains(["vpn", "er"], var.vpn_type)
    error_message = "The vpn_type value must be one of vpn or er."
  }
  default = "vpn"
}

variable "plane" {
  description = "Specifies the vpn gateway plane."
  type        = string
  default     = ""
}

variable "local_network_ref" {
  description = "Specifies the vpn gateway connection local network."
  type        = string
  default     = ""
}

variable "remote_network_ref" {
  description = "Specifies the vpn gateway connection local remote."
  type        = string
  default     = ""
}

variable "kv_env" {
  description = "Specifies the environment, for example: 'p for production' or 'd for deployment'"
  type        = string
  validation {
    condition     = contains(["p", "d", "pp"], var.kv_env)
    error_message = "The kv_env value must be one of p for production, d for development, pp for pre-production in lower case."
  }
  default = "p"
}