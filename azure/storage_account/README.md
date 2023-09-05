# Azure Storage Account Module

## Sumary

The `storage_account` module is an abstraction that implements all the necessary Terraform code to provision an Azure Storage account with success, and accordingly with Visma Nmbrs policies.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | 2.0.0-preview3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurecaf"></a> [azurecaf](#provider\_azurecaf) | 2.0.0-preview3 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.70 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.caf_name](https://registry.terraform.io/providers/aztfmod/azurecaf/2.0.0-preview3/docs/resources/name) | resource |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of storage account. | `string` | n/a | yes |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the storage account. | `string` | n/a | yes |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | Defines the type of replication to use for this storage account. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage Account. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Storage Account. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the storage account. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The connection string associated with the primary location. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for the storage account. |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The connection string associated with the secondary location. |

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
