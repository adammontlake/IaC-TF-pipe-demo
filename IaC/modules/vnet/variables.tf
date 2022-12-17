variable "service_name" {
  description = "(Required) will be the name of the service, for example \"<env>-<service-name>-vnet-<region>\""
  type        = string
  default     = ""
}

variable "environment" {
  description = "(Required) Name of the destination enviroment."
  type        = string
  default     = "dev"
  validation {
    condition = anytrue([
      var.environment == "integration",
      var.environment == "staging",
      var.environment == "prodtesting",
      var.environment == "production",
      var.environment == "pci"
    ])
    error_message = "Environment  must be one of: \"int\", \"stg\", \"pp\" or \"prod\"."
  }
}

variable "resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type        = string
}

variable "location" {
  description = "The location of the vnet to be created."
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "address_spaces" {
  description = "The list of the address spaces that is used by the virtual network."
  type        = list(string)
  default     = []
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = ["1.1.1.1", "1.0.0.1"]
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
  default     = ["subnet1"]
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    environment = "default"
  }
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false."
  type        = map(bool)
  default     = {}
}

variable "subnet_service_endpoints" {
  description = "A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is []."
  type        = map(list(string))
  default     = {}
  #Validate input is in the format of: Microsoft.ServiceName
  validation {
    condition = can(
      [
        for subnet in var.subnet_service_endpoints : [
          for value in subnet : regex("Microsoft\\..{3,20}$", value)
        ]
      ]
    )
    error_message = "Invalid service endpoint name, correct syntax must be: Microsoft.ServiceName."
  }
}