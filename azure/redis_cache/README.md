<!-- BEGIN_TF_DOCS -->
# Redis Cache Module

## Summary

The Azure Redis Cache module is a Terraform module that provides an easy and consistent way to create and manage Redis cache instances in Azure. This module enforces organization-specific naming conventions and security policies while simplifying the provisioning process.

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
| [azurerm_redis_cache.redis](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cache_size_in_gb"></a> [cache\_size\_in\_gb](#input\_cache\_size\_in\_gb) | The size of the Redis cache per instance in gigabytes (GB). | `number` | n/a | yes |
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company / organization. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this Redis instance. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the resource group where the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_sequence_number"></a> [sequence\_number](#input\_sequence\_number) | A numeric value used to ensure uniqueness for resource names. | `number` | n/a | yes |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of shards for the Redis cluster. Only required when using a Premium SKU. | `number` | `0` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Configuration of the size and capacity of the Redis cache. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | Short, descriptive name for the application, service, or workload. Used in resource naming conventions. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The Hostname of the Redis Instance. |
| <a name="output_id"></a> [id](#output\_id) | The Redis ID. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Redis Instance. |
| <a name="output_non_ssl_port"></a> [non\_ssl\_port](#output\_non\_ssl\_port) | The non-SSL Port of the Redis Instance. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the Redis Instance. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string of the Redis Instance. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for the Redis Instance. |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The secondary connection string of the Redis Instance. |
| <a name="output_ssl_port"></a> [ssl\_port](#output\_ssl\_port) | The SSL Port of the Redis Instance. |
| <a name="output_workload"></a> [workload](#output\_workload) | The redis instance workload name. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Basic Redis Cache (Minimal Configuration)

This example shows the minimum required configuration for a Basic Redis cache.

```hcl
module "redis_cache" {
  source = "git::github.com/Nmbrs/tf-modules//azure/redis_cache"

  workload            = "shared"
  company_prefix      = "org"
  sequence_number     = 1
  environment         = "dev"
  location            = "westeurope"
  resource_group_name = "rg-yha-dev"

  sku_name         = "Basic"
  cache_size_in_gb = 1
}
```

### Standard Redis Cache with Standard Naming

This example demonstrates the full naming convention with all optional parameters.

```hcl
module "redis_cache" {
  source = "git::github.com/Nmbrs/tf-modules//azure/redis_cache"

  workload            = "auth"
  company_prefix      = "org"
  sequence_number     = 2
  environment         = "prod"
  location            = "westeurope"
  resource_group_name = "rg-module-prod"

  sku_name         = "Standard"
  cache_size_in_gb = 2.5

  public_network_access_enabled = false
}
```

### Premium Redis Cache (No Clustering)

This example shows a Premium Redis cache without clustering for high performance scenarios.

```hcl
module "redis_cache" {
  source = "git::github.com/Nmbrs/tf-modules//azure/redis_cache"

  workload            = "session"
  environment         = "prod"
  location            = "westeurope"
  resource_group_name = "rg-try-prod"

  sku_name         = "Premium"
  cache_size_in_gb = 6
  shard_count      = 0  # No clustering

  public_network_access_enabled = false
}
```

### Premium Redis Cache with Clustering

This example demonstrates a Premium Redis cache with clustering for scalability.

```hcl
module "redis_cache" {
  source = "git::github.com/Nmbrs/tf-modules//azure/redis_cache"

  workload            = "analytics"
  environment         = "prod"
  location            = "westeurope"
  resource_group_name = "rg-logs-prod"

  sku_name         = "Premium"
  cache_size_in_gb = 26
  shard_count      = 3  # Enable clustering with 3 shards

  public_network_access_enabled = false
}
```

### Custom Named Redis Cache

This example shows how to override the standard naming convention.

```hcl
module "redis_cache" {
  source = "git::github.com/Nmbrs/tf-modules//azure/redis_cache"

  override_name       = "redis-legacy-system"
  environment         = "prod"
  location            = "westeurope"
  resource_group_name = "rg-legacy-prod"

  sku_name         = "Standard"
  cache_size_in_gb = 6
}
```
<!-- END_TF_DOCS -->
