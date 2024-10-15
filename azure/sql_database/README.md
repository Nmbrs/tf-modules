# Sql Database module

## Summary

The `sql_database` module provides a comprehensive Terraform solution for setting up SQL database.
This module streamlines the process of creating and configuring SQL Databases. It handles essential tasks such as provisioning the necessary infrastructure, defining deployment configurations, and establishing platform-specific settings. By abstracting these complexities, the module ensures consistent and efficient deployment of web apps, regardless of the underlying operating system.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_database.sql_database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_mssql_elasticpool.sql_elasticpool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_elasticpool) | data source |
| [azurerm_mssql_server.sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_server) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_collation"></a> [collation](#input\_collation) | The collation to use for the database | `string` | `"SQL_Latin1_General_CP1_CI_AS"` | no |
| <a name="input_elastic_pool_settings"></a> [elastic\_pool\_settings](#input\_elastic\_pool\_settings) | SQL server settings. | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Defines the environment to provision the resources. | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance within the naming convention. | `number` | n/a | yes |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | The license type to apply for this database | `string` | `"BasePrice"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the SQL Server will be created | `string` | n/a | yes |
| <a name="input_max_size_gb"></a> [max\_size\_gb](#input\_max\_size\_gb) | The maximum size of the database in gigabytes, if it's inside an elastic pool this will be ignored and will use 1TB as max size. | `number` | `250` | no |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Override the name of the SQL database, to bypass naming convention | `string` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The name of the SKU used by the database | `string` | `"S0"` | no |
| <a name="input_sql_server_settings"></a> [sql\_server\_settings](#input\_sql\_server\_settings) | SQL server settings. | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | Name of the database to create | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sql_database_collation"></a> [sql\_database\_collation](#output\_sql\_database\_collation) | n/a |
| <a name="output_sql_database_id"></a> [sql\_database\_id](#output\_sql\_database\_id) | n/a |
| <a name="output_sql_database_name"></a> [sql\_database\_name](#output\_sql\_database\_name) | n/a |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### SQL Database + SQL Server

```hcl
module "sql_database" {
  source                = "git::github.com/Nmbrs/tf-modules//azure/sql_database"
  override_name         = null
  workload              = "myapp"
  instance_count        = 1
  environment           = "dev"
  location              = "westeurope"
  sku_name = "S0"
  max_size_gb           = 250 #parameter ignored when using elastic pool
  sql_server_settings = {
    name                = "sqlserver-001"
    resource_group_name = "rg-myresourcegroup"
  }
  elastic_pool_settings = {
    name                = null
    resource_group_name = null
  }
}
```

### SQL Database + SQL Server + SQL Elastic Pool

```hcl
module "sql_database" {
  source                = "git::github.com/Nmbrs/tf-modules//azure/sql_database"
  override_name         = null
  workload              = "myapp"
  instance_count        = 1
  environment           = "dev"
  location              = "westeurope"
  sku_name = "S0"
  max_size_gb           = 1024 #parameter ignored when using elastic pool
  sql_server_settings = {
    name                = "sqlserver-001"
    resource_group_name = "rg-myresourcegroup"
  }
  elastic_pool_settings = {
    name                = "myelasticpool"
    resource_group_name = rg-myrg
  }
}
```
