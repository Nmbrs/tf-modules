# SQL Database Module

## Summary

The `sql_database` module provides a comprehensive Terraform solution for deploying and managing Azure SQL Databases. This module streamlines the process of creating SQL Databases with support for both standalone and elastic pool configurations, flexible naming conventions, and configurable SKU options.

<!-- BEGIN_TF_DOCS -->
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
| [azurerm_mssql_database.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_mssql_elasticpool.sql_elasticpool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_elasticpool) | data source |
| [azurerm_mssql_server.sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_server) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_collation"></a> [collation](#input\_collation) | The collation to use for the database | `string` | `"SQL_Latin1_General_CP1_CI_AS"` | no |
| <a name="input_elastic_pool_settings"></a> [elastic\_pool\_settings](#input\_elastic\_pool\_settings) | SQL elastic pool settings. Optional - if not provided, database will use standalone SKU. | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | The license type to apply for this database | `string` | `"BasePrice"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the SQL Server will be created | `string` | n/a | yes |
| <a name="input_max_size_gb"></a> [max\_size\_gb](#input\_max\_size\_gb) | The maximum size of the database in gigabytes, if it's inside an elastic pool this will be ignored and will use 1TB as max size. | `number` | `250` | no |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Override the name of the SQL database, to bypass naming convention | `string` | `null` | no |
| <a name="input_sequence_number"></a> [sequence\_number](#input\_sequence\_number) | A numeric value used to ensure uniqueness for resource names. | `number` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The name of the SKU used by the database | `string` | `"S0"` | no |
| <a name="input_sql_server_settings"></a> [sql\_server\_settings](#input\_sql\_server\_settings) | SQL server settings. | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>  })</pre> | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | Short, descriptive name for the application, service, or workload. Used in resource naming conventions. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_collation"></a> [collation](#output\_collation) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_workload"></a> [workload](#output\_workload) | n/a |
<!-- END_TF_DOCS -->
## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Standalone database (standard SKU)

```hcl
module "sql_database" {
  source = "./azure/sql_database"

  workload        = "analytics"

  sequence_number = 1
  location        = "westeurope"
  environment     = "prod"

  sql_server_settings = {
    name                = "sqls-nmbrs-analytics-prod-westeurope-001"
    resource_group_name = "rg-sql-prod"
  }

  sku_name    = "S2"
  max_size_gb = 250
}
```

### Standalone database (General Purpose SKU with Azure Hybrid Benefit)

```hcl
module "sql_database" {
  source = "./azure/sql_database"

  workload        = "reporting"

  sequence_number = 1
  location        = "westeurope"
  environment     = "prod"

  sql_server_settings = {
    name                = "sqls-nmbrs-reporting-prod-westeurope-001"
    resource_group_name = "rg-sql-prod"
  }

  sku_name     = "GP_Gen5_4"
  max_size_gb  = 500
  license_type = "LicenseIncluded"
}
```

### Database in elastic pool

```hcl
module "sql_database" {
  source = "./azure/sql_database"

  workload        = "webapp"

  sequence_number = 1
  location        = "westeurope"
  environment     = "prod"

  sql_server_settings = {
    name                = "sqls-nmbrs-webapp-prod-westeurope-001"
    resource_group_name = "rg-sql-prod"
  }

  elastic_pool_settings = {
    name                = "sqlep-nmbrs-prod-westeurope-001"
    resource_group_name = "rg-sql-prod"
  }
}
```

### Override name

```hcl
module "sql_database" {
  source = "./azure/sql_database"

  override_name = "sqldb-custom-name"
  location      = "westeurope"
  environment   = "dev"

  sql_server_settings = {
    name                = "sqls-dev-001"
    resource_group_name = "rg-sql-dev"
  }
}
```
