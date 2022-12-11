# Demo Terraform module for storage account

## Description
The module will create Azure public IP based on guidelines and standards.  
<br />

## Requirements
This module requires the following resources already created:  
- Resource group
<br />

## Naming convention 
The Azure resource will be created with a naming convention  
<br />

## Example
 **main.tf - file usage**  
 

```terraform
module "storage" {
  source                  = "git::https://github.com/IaC-TF-pipe-demo/terraform-modules.git//general/storage"
  service_name            = "terraform"
  resource_group_name     = "testrg"
  location                = "eastus"
  account_tier            = "Standard"
  environment             = production
  terraform_state_storage = true
  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}
```
<br />

## Variables
### Required Variables
```yaml
# The name of the resource on which the naming convention will be applied.
service_name -
    type: string

# The Location of the Azure Firewall to be created
resource_group_name -
    type: string 

# Resource Group of the Azure Firewall to be created
location -
    type: string 

# Tags for the resource to be deployed
account_tier -
    type: map(any)

# The resource environment
environment -
    type: string
    input: integration / staging / production 
```
### Extra variable
```yaml
# The availability zone to allocate the Public IP in
terraform_state_storage -
    type: bool
    default: "Zone-Redundant"

# A mapping of IP tags to assign to the public IP
tags -
    type: map(any)
```
### Local variable 
```yaml
```
### Output 
```yaml
id - 
  description: The Public IP ID
  value: azurerm_public_ip.pip.id
```
## Resources created by the module
- Storage account
<br />

# Change log