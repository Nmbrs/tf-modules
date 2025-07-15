<!-- BEGIN_TF_DOCS -->
# Azure Storage Account Module

## Sumary

The `storage_account` module is an abstraction that implements all the necessary Terraform code to provision an Azure Storage account with success, and accordingly with Visma Nmbrs policies.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of storage account. | `string` | n/a | yes |
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters. | `string` | `"nmbrs"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. If set, this value is used for the resource name. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | A condition to indicate if the Storage Account will have public network access (defaults to false). | `bool` | `false` | no |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | Defines the type of replication to use for this storage account. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Defines the SKU name to use for this storage account. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the storage account. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The storage account ID. |
| <a name="output_name"></a> [name](#output\_name) | The storage account full name. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the storage account. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The connection string associated with the primary location. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for the storage account. |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The connection string associated with the secondary location. |
| <a name="output_workload"></a> [workload](#output\_workload) | The storage account workload name. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Storage Account with Public Network Access Enabled
```hcl
module "storage_account" {
  source                        = "git::github.com/Nmbrs/tf-modules/azure/storage_account"
  workload                      = "demo"
  resource_group_name           = "rg-my-resource-group"
  account_kind                  = "StorageV2"
  sku_name                      = "Standard_LRS"
  replication_type              = "LRS"
  environment                   = "prod"
  location                      = "westeurope"
  company_prefix                = "myorg"
  override_name                 = null
  public_network_access_enabled = true
}
```

### Storage Account with Public Network Access Disabled
```hcl
module "storage_account" {
  source                        = "git::github.com/Nmbrs/tf-modules/azure/storage_account"
  workload                      = "demo"
  resource_group_name           = "rg-my-resource-group"
  account_kind                  = "StorageV2"
  sku_name                      = "Standard_GRS"
  replication_type              = "GRS"
  environment                   = "dev"
  location                      = "westeurope"
  company_prefix                = "myorg"
  override_name                 = null
  public_network_access_enabled = false
}
```
<!-- END_TF_DOCS -->
