<!-- BEGIN_TF_DOCS -->
# IaC demo pipeline - autogenerated module documentation
```hcl
This module create public ip's based on the HLD.

Depends on:
1. Resource group
```
## Example ussage
```hcl
module "public_ip" {
  source               = "git::https://github.com/microsoft/PDC//IaC/Modules/public_ip"
  providers            = { azurerm = azurerm.sub-connectivity-platform }
  environment          = "production"
  workload             = "connectivity"
  subscription_purpose = "firewall"
  rg_name              = "rg-firewall-production"
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Specifies the environment, for example: 'production' or 'pre-production' | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Optional) Specifies the location, for example: 'north Europe' or 'west Europe'. | `string` | `"West Europe"` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | (Required) Specifies the public ip's resource group name. | `string` | n/a | yes |
| <a name="input_subscription_purpose"></a> [subscription\_purpose](#input\_subscription\_purpose) | Specifies the pip connected resource subscription purpose. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) Specifies the public ip's workload. | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | Specifies the pip zones. | `list(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pip_id"></a> [pip\_id](#output\_pip\_id) | n/a |
| <a name="output_pip_ip"></a> [pip\_ip](#output\_pip\_ip) | n/a |
| <a name="output_pip_name"></a> [pip\_name](#output\_pip\_name) | n/a |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

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