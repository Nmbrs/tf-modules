# SQL Server Module

## Summary

The `sql_server` module provides a comprehensive Terraform solution for deploying and managing Azure SQL Servers. This module streamlines the process of creating SQL Servers with support for Azure AD authentication, network security, auditing, and flexible naming conventions.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.7.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_firewall_rule.sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server_extended_auditing_policy.sql_auditing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) | resource |
| [azurerm_mssql_virtual_network_rule.sql_server_network_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_network_rule) | resource |
| [azuread_group.azuread_sql_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_key_vault.local_sql_admin_key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.local_sql_admin_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_storage_account.auditing_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auditing_settings"></a> [auditing\_settings](#input\_auditing\_settings) | The settings necessary for the storage account auditing. Required for prod and sand environments, optional for others. | <pre>object({<br/>    storage_account_name           = string<br/>    storage_account_resource_group = string<br/>  })</pre> | `null` | no |
| <a name="input_azuread_authentication_only_enabled"></a> [azuread\_authentication\_only\_enabled](#input\_azuread\_authentication\_only\_enabled) | Specifies if only Azure AD authentication is allowed | `bool` | `true` | no |
| <a name="input_azuread_sql_admin"></a> [azuread\_sql\_admin](#input\_azuread\_sql\_admin) | The name of the admin (Azure AD group) that will be SQL Server admin | `string` | n/a | yes |
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company / organization. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_local_sql_admin_user_settings"></a> [local\_sql\_admin\_user\_settings](#input\_local\_sql\_admin\_user\_settings) | The settings necessary for the local SQL admin creation, the username and the key vault settings for the password. | <pre>object({<br/>    local_sql_admin_user = string<br/>    local_sql_admin_user_password = object({<br/>      key_vault_name           = string<br/>      key_vault_resource_group = string<br/>      key_vault_secret_name    = string<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | Network configuration settings for the SQL Server, including public access, firewall rules, and allowed subnets. | <pre>object({<br/>    public_network_access_enabled            = bool<br/>    trusted_services_bypass_firewall_enabled = bool<br/>    allowed_subnets = list(object({<br/>      subnet_name                = string<br/>      virtual_network_name       = string<br/>      subnet_resource_group_name = string<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the resource group where the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_sequence_number"></a> [sequence\_number](#input\_sequence\_number) | A numeric value used to ensure uniqueness for resource names. | `number` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | Short, descriptive name for the application, service, or workload. Used in resource naming conventions. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name of the SQL Server. |
| <a name="output_id"></a> [id](#output\_id) | The SQL Server ID. |
| <a name="output_name"></a> [name](#output\_name) | The SQL Server full name. |
| <a name="output_workload"></a> [workload](#output\_workload) | The SQL Server workload. |
<!-- END_TF_DOCS -->

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### SQL Server for production with auditing

```hcl
module "sql_server" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/sql_server"
  workload            = "analytics"
  company_prefix      = "nmbrs"
  sequence_number     = 1
  resource_group_name = "rg-sql-prod"
  location            = "westeurope"
  environment         = "prod"
  azuread_sql_admin   = "sg-sql-admins"

  local_sql_admin_user_settings = {
    local_sql_admin_user = "sqlcloudadmin"
    local_sql_admin_user_password = {
      key_vault_name           = "kv-nmbrs-secrets-prod"
      key_vault_resource_group = "rg-keyvault-prod"
      key_vault_secret_name    = "sql-admin-password"
    }
  }

  network_settings = {
    public_network_access_enabled            = false
    trusted_services_bypass_firewall_enabled = false
    allowed_subnets                          = []
  }

  auditing_settings = {
    storage_account_name           = "stnmbrsauditprod"
    storage_account_resource_group = "rg-audit-prod"
  }
}
```

### SQL Server for development without auditing

```hcl
module "sql_server" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/sql_server"
  workload            = "myapp"
  company_prefix      = "nmbrs"
  sequence_number     = 1
  resource_group_name = "rg-sql-dev"
  location            = "westeurope"
  environment         = "dev"
  azuread_sql_admin   = "sg-sql-admins-dev"

  local_sql_admin_user_settings = {
    local_sql_admin_user = "sqladmin"
    local_sql_admin_user_password = {
      key_vault_name           = "kv-nmbrs-secrets-dev"
      key_vault_resource_group = "rg-keyvault-dev"
      key_vault_secret_name    = "sql-admin-password"
    }
  }

  network_settings = {
    public_network_access_enabled            = false
    trusted_services_bypass_firewall_enabled = false
    allowed_subnets                          = []
  }
}
```

### SQL Server with public access and VNet rules

```hcl
module "sql_server" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/sql_server"
  workload            = "webapp"
  company_prefix      = "nmbrs"
  sequence_number     = 1
  resource_group_name = "rg-sql-prod"
  location            = "westeurope"
  environment         = "prod"
  azuread_sql_admin   = "sg-sql-admins"

  local_sql_admin_user_settings = {
    local_sql_admin_user = "sqlcloudadmin"
    local_sql_admin_user_password = {
      key_vault_name           = "kv-nmbrs-secrets-prod"
      key_vault_resource_group = "rg-keyvault-prod"
      key_vault_secret_name    = "sql-admin-password"
    }
  }

  network_settings = {
    public_network_access_enabled            = true
    trusted_services_bypass_firewall_enabled = true
    allowed_subnets = [
      {
        subnet_name                = "snet-app-001"
        virtual_network_name       = "vnet-nmbrs-prod-westeurope-001"
        subnet_resource_group_name = "rg-network-prod"
      }
    ]
  }

  auditing_settings = {
    storage_account_name           = "stnmbrsauditprod"
    storage_account_resource_group = "rg-audit-prod"
  }
}
```

### SQL Server with a custom name override

```hcl
module "sql_server" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/sql_server"
  override_name       = "sqls-my-custom-name-001"
  resource_group_name = "rg-sql-prod"
  location            = "westeurope"
  environment         = "prod"
  azuread_sql_admin   = "sg-sql-admins"

  local_sql_admin_user_settings = {
    local_sql_admin_user = "sqlcloudadmin"
    local_sql_admin_user_password = {
      key_vault_name           = "kv-nmbrs-secrets-prod"
      key_vault_resource_group = "rg-keyvault-prod"
      key_vault_secret_name    = "sql-admin-password"
    }
  }

  network_settings = {
    public_network_access_enabled            = false
    trusted_services_bypass_firewall_enabled = false
    allowed_subnets                          = []
  }

  auditing_settings = {
    storage_account_name           = "stnmbrsauditprod"
    storage_account_resource_group = "rg-audit-prod"
  }
}
```
