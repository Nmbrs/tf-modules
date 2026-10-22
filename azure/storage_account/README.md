<!-- BEGIN_TF_DOCS -->
# Azure Storage Account Module

## Summary

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | git::github.com/Nmbrs/tf-modules//azure/private_endpoint | 49dc7f61a161fb90b42471ba30c15157384b6035 |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of storage account. | `string` | n/a | yes |
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | Network settings shared by all storage account private endpoints. | <pre>object({<br/>    subnet_name              = string<br/>    vnet_name                = string<br/>    vnet_resource_group_name = string<br/>  })</pre> | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. If set, this value is used for the resource name. | `string` | `null` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | Resource IDs of the private DNS zones used by each storage account private endpoint. Required keys: `blob`, `table`, `file`, `queue`. | <pre>object({<br/>    blob  = string<br/>    table = string<br/>    file  = string<br/>    queue = string<br/>  })</pre> | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | A condition to indicate if the Storage Account will have public network access (defaults to false). | `bool` | `false` | no |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | Defines the type of replication to use for this storage account. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Defines the SKU name to use for this storage account. | `string` | n/a | yes |
| <a name="input_trusted_services_bypass_firewall_enabled"></a> [trusted\_services\_bypass\_firewall\_enabled](#input\_trusted\_services\_bypass\_firewall\_enabled) | Allow trusted Microsoft services to bypass this firewall. When enabled, trusted Microsoft services can access the Storage Account even when network access is restricted. | `bool` | `true` | no |
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

The module always provisions four private endpoints for the storage account — one each for the `blob`, `table`, `file`, and `queue` subresources. Every caller must supply `network_settings` and a `private_dns_zone_ids` map containing the DNS zone ID for each subresource. The examples below assume the relevant subnet and `privatelink.<subresource>.core.windows.net` DNS zones already exist.

### Standard storage account (private network access only)

```hcl
module "storage_account" {
  source = "git::github.com/Nmbrs/tf-modules//azure/storage_account"

  workload            = "demo"
  company_prefix      = "myorg"
  resource_group_name = "rg-my-resource-group"
  location            = "westeurope"
  environment         = "prod"
  account_kind        = "StorageV2"
  sku_name            = "Standard"
  replication_type    = "LRS"

  network_settings = {
    subnet_name              = "snet-private-endpoints"
    vnet_name                = "vnet-myenv"
    vnet_resource_group_name = "rg-networking"
  }

  private_dns_zone_ids = {
    blob  = module.dns_zone_blob.id
    table = module.dns_zone_table.id
    file  = module.dns_zone_file.id
    queue = module.dns_zone_queue.id
  }
}
```

### Storage account with public network access enabled

Use this variant when the account must remain reachable from public networks alongside the private endpoints (e.g., migration scenarios or trusted-service bypass).

```hcl
module "storage_account" {
  source = "git::github.com/Nmbrs/tf-modules//azure/storage_account"

  workload                      = "demo"
  company_prefix                = "myorg"
  resource_group_name           = "rg-my-resource-group"
  location                      = "westeurope"
  environment                   = "prod"
  account_kind                  = "StorageV2"
  sku_name                      = "Standard"
  replication_type              = "GRS"
  public_network_access_enabled = true

  network_settings = {
    subnet_name              = "snet-private-endpoints"
    vnet_name                = "vnet-myenv"
    vnet_resource_group_name = "rg-networking"
  }

  private_dns_zone_ids = {
    blob  = module.dns_zone_blob.id
    table = module.dns_zone_table.id
    file  = module.dns_zone_file.id
    queue = module.dns_zone_queue.id
  }
}
```
<!-- END_TF_DOCS -->
