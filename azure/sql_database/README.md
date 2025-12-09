# SQL Database Module

## Summary

The `sql_database` module provides a comprehensive Terraform solution for deploying and managing Azure SQL Databases. This module streamlines the process of creating SQL Databases with support for both standalone and elastic pool configurations, flexible naming conventions, and configurable SKU options.

## Features

- **Flexible Naming**: Supports both automatic naming and manual override
- **Elastic Pool Support**: Optional integration with SQL elastic pools
- **Configurable SKUs**: Support for Standard and General Purpose tier options
- **Flexible Sizing**: Configurable maximum database size
- **License Options**: Support for License Included and Base Price models
- **Lifecycle Preconditions**: Validates naming configuration at plan time

## Naming Convention

### Automatic Naming
- **Pattern**: `sqldb-{company_prefix}-{workload}-{environment}-{location}-{sequence_number}`
- **Example**: `sqldb-nmbrs-analytics-prod-westeurope-001`

### Override Naming
- Use `override_name` to bypass automatic naming
- Must follow Azure SQL Database naming rules

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0, < 2.0.0 |
| azurerm | ~> 3.0 |

## Usage Examples

### Example 1: Standalone Database with Automatic Naming
```hcl
module "sql_database" {
  source = "git::github.com/Nmbrs/tf-modules//azure/sql_database"

  # Naming variables
  workload         = "analytics"
  company_prefix   = "nmbrs"
  sequence_number  = 1
  override_name    = null

  # Standard variables
  location    = "westeurope"
  environment = "prod"

  # SQL Server configuration
  sql_server_settings = {
    name                = "sqls-nmbrs-analytics-prod-westeurope-001"
    resource_group_name = "rg-sql-prod"
  }

  # Database configuration
  sku_name    = "S2"
  max_size_gb = 250
  collation   = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "BasePrice"

  # No elastic pool
  elastic_pool_settings = null
}
```

### Example 2: Database in Elastic Pool
```hcl
module "sql_database" {
  source = "git::github.com/Nmbrs/tf-modules//azure/sql_database"

  # Naming variables
  workload         = "webapp"
  company_prefix   = "nmbrs"
  sequence_number  = 1

  # Standard variables
  location    = "westeurope"
  environment = "prod"

  # SQL Server configuration
  sql_server_settings = {
    name                = "sqls-nmbrs-webapp-prod-westeurope-001"
    resource_group_name = "rg-sql-prod"
  }

  # Database configuration
  # SKU and max_size_gb are ignored when using elastic pool
  sku_name    = "S0"
  max_size_gb = 1024
  collation   = "SQL_Latin1_General_CP1_CI_AS"

  # Elastic pool configuration
  elastic_pool_settings = {
    name                = "sqlep-nmbrs-prod-westeurope-001"
    resource_group_name = "rg-sql-prod"
  }
}
```

### Example 3: Database with Override Name
```hcl
module "sql_database" {
  source = "git::github.com/Nmbrs/tf-modules//azure/sql_database"

  # Use override name instead of automatic naming
  override_name = "sqldb-custom-name-001"

  # Standard variables
  location    = "westeurope"
  environment = "dev"

  # SQL Server configuration
  sql_server_settings = {
    name                = "sqls-dev-001"
    resource_group_name = "rg-sql-dev"
  }

  # Database configuration
  sku_name     = "S1"
  max_size_gb  = 100
  license_type = "BasePrice"

  # No elastic pool
  elastic_pool_settings = null
}
```

### Example 4: General Purpose Database
```hcl
module "sql_database" {
  source = "git::github.com/Nmbrs/tf-modules//azure/sql_database"

  # Naming variables
  workload         = "reporting"
  company_prefix   = "nmbrs"
  sequence_number  = 2

  # Standard variables
  location    = "westeurope"
  environment = "prod"

  # SQL Server configuration
  sql_server_settings = {
    name                = "sqls-nmbrs-reporting-prod-westeurope-001"
    resource_group_name = "rg-sql-prod"
  }

  # Database configuration - General Purpose tier
  sku_name     = "GP_Gen5_4"
  max_size_gb  = 500
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"

  # No elastic pool
  elastic_pool_settings = null
}
```

## Variables

### Required Variables

| Name | Type | Description |
|------|------|-------------|
| `location` | string | The Azure region for deployment |
| `environment` | string | Environment (dev, test, prod, sand, stag, stage) |
| `sql_server_settings` | object | SQL Server configuration |

### Optional Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `workload` | string | null | Workload name (required if override_name not provided) |
| `company_prefix` | string | null | Company prefix, 1-5 chars (required if override_name not provided) |
| `sequence_number` | number | null | Sequence number 1-999 (required if override_name not provided) |
| `override_name` | string | null | Override automatic naming |
| `elastic_pool_settings` | object | null | Elastic pool configuration (optional) |
| `collation` | string | "SQL_Latin1_General_CP1_CI_AS" | Database collation |
| `license_type` | string | "BasePrice" | License type (LicenseIncluded, BasePrice) |
| `sku_name` | string | "S0" | Database SKU name |
| `max_size_gb` | number | 250 | Maximum database size in GB |

### Variable Details

#### sql_server_settings
```hcl
{
  name                = string
  resource_group_name = string
}
```

#### elastic_pool_settings (optional)
```hcl
{
  name                = string
  resource_group_name = string
}
```

## Outputs

| Name | Description |
|------|-------------|
| `sql_database_name` | The name of the SQL Database |
| `sql_database_id` | The ID of the SQL Database |
| `sql_database_collation` | The collation of the SQL Database |

## Validation Rules

### Naming Validation
- Either `override_name` must be provided, OR all of `workload`, `company_prefix`, and `sequence_number` must be provided
- Validated at plan time via lifecycle precondition

### SKU Validation
- Valid options: S0, S1, S2, S3, S4, GP_Gen5_2, GP_Gen5_4, GP_Gen5_6, GP_Gen5_8, GP_Gen5_10, GP_Gen5_12, GP_Gen5_14, GP_Gen5_16, GP_Gen5_18, GP_Gen5_20

### License Type Validation
- Valid options: LicenseIncluded, BasePrice

## Elastic Pool Behavior

When `elastic_pool_settings` is provided:
- Database is assigned to the specified elastic pool
- `sku_name` is set to `null` (pool controls resources)
- `max_size_gb` is ignored (pool controls sizing)

When `elastic_pool_settings` is `null`:
- Database is standalone with specified `sku_name`
- `max_size_gb` applies to the database

## Resources Created

- `azurerm_mssql_database` - The SQL Database instance

## Data Sources Used

- `azurerm_mssql_server` - Reference to existing SQL Server
- `azurerm_mssql_elasticpool` - Reference to elastic pool (if configured)

## Notes

- Tags are ignored in lifecycle to prevent drift
- When using elastic pools, ensure the pool has sufficient resources for all databases
- The `sql_server_settings.name` can include or exclude the `.database.windows.net` suffix (module handles both)
