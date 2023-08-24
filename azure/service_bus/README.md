<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_servicebus_namespace.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The number of message units. | `number` | `0` | no |
| <a name="input_location"></a> [location](#input\_location) | The name of the location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the namespace. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the rg. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the namespace. The options are: `Basic`, `Standard`, `Premium`. | `string` | `"Standard"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_connection_string"></a> [default\_connection\_string](#output\_default\_connection\_string) | The primary connection string for the authorization rule RootManageSharedAccessKey which is created automatically by Azure. |
| <a name="output_id"></a> [id](#output\_id) | The namespace ID. |
| <a name="output_name"></a> [name](#output\_name) | The namespace name. |
<!-- END_TF_DOCS -->