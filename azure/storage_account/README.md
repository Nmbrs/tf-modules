# Azure Storage Account Module

## Sumary

The `storage_account` module is an abstraction that implements all the necessary
Terraform code to provision an Azure Storage account with success, and accordingly with Visma Nmbrs policies.

## Requirements

| Name                                                                     | Version           |
| ------------------------------------------------------------------------ | ----------------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement_azurecaf)    | 2.0.0-preview3    |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | ~> 3.6            |

## Providers

| Name                                                            | Version        |
| --------------------------------------------------------------- | -------------- |
| <a name="provider_azurecaf"></a> [azurecaf](#provider_azurecaf) | 2.0.0-preview3 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)    | 3.6            |

## Modules

No modules.

## Resources

| Name                                                                                                                                       | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [azurecaf_name.caf_name](https://registry.terraform.io/providers/aztfmod/azurecaf/2.0.0-preview3/docs/resources/name)                      | resource    |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource    |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)             | data source |

## Inputs

| Name                                                                                       | Description                                                             | Type     | Default | Required |
| ------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------- | -------- | ------- | :------: |
| <a name="input_account_kind"></a> [account_kind](#input_account_kind)                      | Defines the Kind of storage account.                                    | `string` | n/a     |   yes    |
| <a name="input_account_tier"></a> [account_tier](#input_account_tier)                      | Defines the Tier to use for this storage account.                       | `string` | n/a     |   yes    |
| <a name="input_environment"></a> [environment](#input_environment)                         | (Optional) The environment in which the resource should be provisioned. | `string` | `"dev"` |    no    |
| <a name="input_name"></a> [name](#input_name)                                              | Name of the storage account.                                            | `string` | n/a     |   yes    |
| <a name="input_replication_type"></a> [replication_type](#input_replication_type)          | Defines the type of replication to use for this storage account.        | `string` | n/a     |   yes    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | The name of an existing Resource Group.                                 | `string` | n/a     |   yes    |

## Outputs

| Name                                                                                                                 | Description                                                   |
| -------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| <a name="output_id"></a> [id](#output_id)                                                                            | The ID of the Storage Account.                                |
| <a name="output_name"></a> [name](#output_name)                                                                      | The name of the Storage Account.                              |
| <a name="output_primary_access_key"></a> [primary_access_key](#output_primary_access_key)                            | The primary access key for the storage account.               |
| <a name="output_primary_connection_string"></a> [primary_connection_string](#output_primary_connection_string)       | The connection string associated with the primary location.   |
| <a name="output_secondary_access_key"></a> [secondary_access_key](#output_secondary_access_key)                      | The secondary access key for the storage account.             |
| <a name="output_secondary_connection_string"></a> [secondary_connection_string](#output_secondary_connection_string) | The connection string associated with the secondary location. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "storage_account" {
  source              = "git::github.com/Nmbrs/tf-modules/azure/storage_account"
  name                = "sauniquename123"
  resource_group_name = "rg-my-resource-group"
  account_kind     = "Storage"
  account_tier     = "Standard"
  replication_type = "GRS"
}
```
