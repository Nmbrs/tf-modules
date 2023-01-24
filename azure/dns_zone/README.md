# DNS Zone Module

## Sumary

The `dns_zone` module is an abstraction that implements all the necessary
Terraform code to provision an Azure Keyvault with success, and accordingly with
Visma Nmbrs policies.

## Requirements

| Name                                                                     | Version           |
| ------------------------------------------------------------------------ | ----------------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | ~> 3.6            |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | ~> 3.6  |

## Modules

No modules.

## Resources

| Name                                                                                                                  | Type     |
| --------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_dns_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |

## Inputs

| Name                                                                                       | Description                                                         | Type          | Default | Required |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------- | ------------- | ------- | :------: |
| <a name="input_name"></a> [name](#input_name)                                              | The name of the DNS Zone. Must be a valid domain name.              | `string`      | n/a     |   yes    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | The name of an existing Resource Group.                             | `string`      | n/a     |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                              | A mapping of tags which should be assigned to the desired resource. | `map(string)` | n/a     |   yes    |

## Outputs

| Name                                                                                                           | Description                                               |
| -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| <a name="output_id"></a> [id](#output_id)                                                                      | The DNS Zone ID.                                          |
| <a name="output_max_number_of_record_sets"></a> [max_number_of_record_sets](#output_max_number_of_record_sets) | Maximum number of Records in the zone.                    |
| <a name="output_name"></a> [name](#output_name)                                                                | The DNS Zone name.                                        |
| <a name="output_name_servers"></a> [name_servers](#output_name_servers)                                        | A list of values that make up the NS record for the zone. |
| <a name="output_number_of_record_sets"></a> [number_of_record_sets](#output_number_of_record_sets)             | The number of records already in the zone.                |

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