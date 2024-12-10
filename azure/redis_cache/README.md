<!-- BEGIN_TF_DOCS -->
# Redis Cache Module

## Summary

The Azure Redis cache module is a Terraform module that provides an easy and consistent way to create and manage Redis cache instances in Azure. This module enforces organization-specific policies and guidelines to ensure compliance, while also simplifying the provisioning process for Redis cache instances. The module automatically configures necessary parameters such as capacity, family, and sku_name based on the cache size selected by the user. With this module, users can quickly provision and manage Azure Redis caches, making it an ideal solution for those looking to streamline Nmbrs Redis cache infrastructure.

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
| [azurerm_redis_cache.redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cache_size_in_gb"></a> [cache\_size\_in\_gb](#input\_cache\_size\_in\_gb) | The size of the Redis cache per instance in gigabytes (GB) | `number` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this redis instance. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of shards for the Redis cluster. | `number` | `0` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Configuration of the size and capacity of the redis cache. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the redis instance. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The Hostname of the Redis Instance. |
| <a name="output_id"></a> [id](#output\_id) | The Redis ID. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Redis Instance. |
| <a name="output_non_ssl_port"></a> [non\_ssl\_port](#output\_non\_ssl\_port) | The non-SSL Port of the Redis Instance. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for  the Redis Instance. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string of the Redis Instance. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for  the Redis Instance. |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The primary connection string of the Redis Instance. |
| <a name="output_ssl_port"></a> [ssl\_port](#output\_ssl\_port) | The SSL Port of the Redis Instance. |
| <a name="output_workload"></a> [workload](#output\_workload) | The redis instance workload name. |


## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Premium cache with no cluster configuration
```hcl
module "redis_cache" {
  source                        = "git::github.com/Nmbrs/tf-modules//azure/redis_cache"
  name                          = "my-redis-cache"
  resource_group_name           = "rg-my-resource-group"
  environment                   = "dev"
  location                      = "westeurope"
  sku_name                      = "Premium"
  cache_size_in_gb              = 6
  network_public_access_enabled = false
}

```

### Premium cache with cluster configuration
```hcl
module "redis_cache" {
  source                        = "git::github.com/Nmbrs/tf-modules//azure/redis_cache"
  workload                      = "my-redis-cache"
  resource_group_name           = "rg-my-resource-group"
  environment                   = "dev"
  location                      = "westeurope"
  sku_name                      = "Premium"
  cache_size_in_gb              = 6
  shard_count                   = 2
  network_public_access_enabled = false
}
```

### Basic cache
```hcl
module "redis_cache" {
  source                        = "git::github.com/Nmbrs/tf-modules//azure/redis_cache"
  workload                      = "my-redis-cache"
  resource_group_name           = "rg-my-resource-group"
  environment                   = "dev"
  location                      = "westeurope"
  sku_name                      = "Basic"
  cache_size_in_gb              = 1
  network_public_access_enabled = false
}
```

### Standard cache
```hcl
module "redis_cache" {
  source                        = "git::github.com/Nmbrs/tf-modules//azure/redis_cache"
  workload                      = "my-redis-cache"
  resource_group_name           = "rg-my-resource-group"
  environment                   = "dev"
  location                      = "westeurope"
  sku_name                      = "Basic"
  cache_size_in_gb              = 2.5
  network_public_access_enabled = false
}
```
<!-- END_TF_DOCS -->
