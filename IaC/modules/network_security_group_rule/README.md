<!-- BEGIN_TF_DOCS -->
# IaC demo pipeline - autogenerated module documentation
```hcl
This module creates a list of network security group's rules based on the HLD.

Note: the NSG rules module depends on the creation of the following resources:
1. Vnet with subnets
2. NSG
3. ASG
4. Connected resources
```
## Example ussage
```hcl
module "network_security_group_rule" {
  source          = "git::https://github.com/microsoft/PDC//IaC/Modules/network_security_group_rule"
  providers       = { azurerm = azurerm.sub-shared_resources-platform }
  environment     = "production"
  nsg_rules       = [
    {
      nsg_name             = "nsg-snet-private_endpoints_shared_resources"
      nsg_rg_name          = "rg-shared_resources-network-prod"
      direction            = "i"
      action               = "Allow"
      source_resource      = "GitHub-Runnerrs-ASG"
      destination_resource = "Github-Servers-IP"
      description          = "DESC"
      protocol             = "Tcp"
      src_port             = "*"
      dest_port            = "*"
      src_address          = "*"
      dest_address         = "*"
      priority             = 100
    }
  ]
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Specifies the environment, for example: 'production' or 'pre-production' | `string` | n/a | yes |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | (Required) Specifies the network security group's rules objects. | <pre>list(object({<br>    nsg_name             = string<br>    nsg_rg_name          = string<br>    direction            = optional(string, "i")<br>    action               = optional(string, "Allow")<br>    source_resource      = string<br>    destination_resource = string<br>    description          = optional(string, "DESC")<br>    protocol             = optional(string, "*")<br>    src_port             = optional(string, "*")<br>    dest_port            = optional(string, "*")<br>    src_address          = optional(string, null)<br>    src_asg_ids          = optional(list(string), null)<br>    dest_address         = optional(string, null)<br>    dest_asg_ids         = optional(list(string), null)<br>    priority             = number<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_rule.rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |

## Requirements

No requirements.

## Change log
```hcl
 - V1.0.0 - module created
```
## Footer
```hcl
This README was generated automatically with [terraform-docs](https://terraform-docs.io/).
Docks are validated and corrected during push.
```
<!-- END_TF_DOCS -->