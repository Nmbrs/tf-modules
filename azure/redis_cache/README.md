# Redis Cache Module

## Summary

The Azure Redis cache module is a Terraform module that provides an easy and consistent way to create and manage Redis cache instances in Azure. This module enforces organization-specific policies and guidelines to ensure compliance, while also simplifying the provisioning process for Redis cache instances. The module automatically configures necessary parameters such as capacity, family, and sku_name based on the cache size selected by the user. With this module, users can quickly provision and manage Azure Redis caches, making it an ideal solution for those looking to streamline Nmbrs Redis cache infrastructure.

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
| [azurerm_redis_cache.redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.redis_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cache_size_gb"></a> [cache\_size\_gb](#input\_cache\_size\_gb) | The size of the Redis cache per instance in gigabytes (GB) | `number` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the  Redis instance. It must follow the CAF naming convention. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The Hostname of the Redis Instance. |
| <a name="output_id"></a> [id](#output\_id) | Redis ID. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Redis Instance. |
| <a name="output_non_ssl_port"></a> [non\_ssl\_port](#output\_non\_ssl\_port) | The non-SSL Port of the Redis Instance. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for  the Redis Instance. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string of the Redis Instance. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for  the Redis Instance. |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The primary connection string of the Redis Instance. |
| <a name="output_ssl_port"></a> [ssl\_port](#output\_ssl\_port) | ssl\_port - The SSL Port of the Redis Instance. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "redis_cache" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/redis_cache"
  name                = "my-redis-cache"
  resource_group_name = "rg-my-resource-group"
  environment         = "dev"
  cache_size_gb       = 6
}
```
