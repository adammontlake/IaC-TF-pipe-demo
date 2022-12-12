<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | git::https://github.com/adammontlake/IaC-TF-pipe-demo.git//IaC/modules/naming_convention | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.terraform_state_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | The account\_tier of the storage account. Accepted values are Basic and Standard. Defaults to Basic. | `string` | `"Basic"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the destination enviroment. | `string` | `"production"` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where to create the resource. | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | will be the name of the service, for example "<env>-<service-name>-storage-<region>" | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the resource to be deployed. | `map(any)` | `null` | no |
| <a name="input_terraform_state_storage"></a> [terraform\_state\_storage](#input\_terraform\_state\_storage) | Define storage as dedicated for holoding Terraform state | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The storage account ID |
<!-- END_TF_DOCS -->