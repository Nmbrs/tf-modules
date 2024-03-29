# DNS Zone Module

## Sumary

The `dns_zone` module is an abstraction that implements all the necessary
Terraform code to provision an Azure Keyvault with success, and accordingly with Visma Nmbrs policies.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.70 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the DNS Zone. Must be a valid domain name. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The DNS Zone ID. |
| <a name="output_max_number_of_record_sets"></a> [max\_number\_of\_record\_sets](#output\_max\_number\_of\_record\_sets) | Maximum number of Records in the zone. |
| <a name="output_name"></a> [name](#output\_name) | The DNS Zone name. |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | A list of values that make up the NS record for the zone. |
| <a name="output_number_of_record_sets"></a> [number\_of\_record\_sets](#output\_number\_of\_record\_sets) | The number of records already in the zone. |


## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "dns_zone" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/dns_zone"
  name                = "contoso.com.dev"
  resource_group_name = "rg-demo-staging"
}
```

## DNS Zone naming rules:

The following rules should be applied when defining a name for the DNS Zone:

- It must be between 3 and 24 characters.
- The last TLD (Top level domain) must be at least 2 characters long and no more than 6 characters long. It must also contain only letters.
- It must contain no more than 2 subdomains. Only letters, digits, and dashes are allowed in the subdomain name. However, the name must not end or begin with dashes.

### Valid Examples

- subomain1.sudomain2.com
- example.com
