# SQL Server Module

## Summary

The `sql_server` module provides a comprehensive Terraform solution for deploying and managing Azure SQL Servers. This module streamlines the process of creating SQL Servers with support for Azure AD authentication, network security, auditing, and flexible naming conventions.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.8.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | git::github.com/Nmbrs/tf-modules//azure/private_endpoint | f41a116c9f31892191b5e3f146a1e361bfc57322 |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_mssql_firewall_rule.sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule) | resource |
| [azurerm_mssql_server.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |
| [azurerm_mssql_server_extended_auditing_policy.sql_auditing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) | resource |
| [azurerm_mssql_virtual_network_rule.sql_server_network_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_network_rule) | resource |
| [azuread_group.azuread_sql_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_key_vault_secret.local_sql_admin_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_storage_account.auditing_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_admin_settings"></a> [admin\_settings](#input\_admin\_settings) | Administrative access for the SQL Server: Azure AD group, AAD-only mode, and the local SQL admin used at server creation (Azure requires a local admin even when AAD-only mode is enabled). The local admin password is read from a Key Vault secret identified by the vault's resource ID and the secret name. | <pre>object({<br/>    azuread_group_name                  = string<br/>    azuread_authentication_only_enabled = optional(bool, true)<br/>    local_username                      = string<br/>    local_password_secret = object({<br/>      key_vault_id = string<br/>      secret_name  = string<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_auditing_settings"></a> [auditing\_settings](#input\_auditing\_settings) | The settings necessary for the storage account auditing. Required for prod and sand environments, optional for others. | <pre>object({<br/>    storage_account_name           = string<br/>    storage_account_resource_group = string<br/>  })</pre> | `null` | no |
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company / organization. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_firewall_settings"></a> [firewall\_settings](#input\_firewall\_settings) | Firewall configuration: public access, trusted-service bypass, and allowed subnets for VNet rules. All fields are optional and default to a secure-by-default posture (no public access, no allowed subnets, trusted-service bypass enabled). | <pre>object({<br/>    public_network_access_enabled            = optional(bool, false)<br/>    trusted_services_bypass_firewall_enabled = optional(bool, true)<br/>    allowed_subnet_ids                       = optional(list(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. | `string` | `null` | no |
| <a name="input_private_endpoint_settings"></a> [private\_endpoint\_settings](#input\_private\_endpoint\_settings) | Settings for the private endpoint provisioned by this module. `subnet_id` is the resource ID of the subnet where the PEP NIC lands. `private_dns_zone_ids` maps each required subresource to its private DNS zone resource ID. | <pre>object({<br/>    subnet_id = string<br/>    private_dns_zone_ids = object({<br/>      sqlServer = string<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the resource group where the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_sequence_number"></a> [sequence\_number](#input\_sequence\_number) | A numeric value used to ensure uniqueness for resource names. | `number` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | Short, descriptive name for the application, service, or workload. Used in resource naming conventions. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name of the SQL Server. |
| <a name="output_id"></a> [id](#output\_id) | The SQL Server ID. |
| <a name="output_name"></a> [name](#output\_name) | The SQL Server full name. |
| <a name="output_workload"></a> [workload](#output\_workload) | The SQL Server workload. |
<!-- END_TF_DOCS -->

## How to use it?

The module always provisions a private endpoint for the SQL Server (`sqlServer` subresource). Every caller must supply `private_endpoint_settings` with the subnet ID where the PEP NIC lands and the resource ID of the `privatelink.database.windows.net` DNS zone. The `firewall_settings` variable is optional and defaults to a private-only posture (no public network access, no allowed subnets, trusted-service bypass enabled) — omit it entirely to use the defaults, or override specific fields as shown in the third example.

### SQL Server for production with auditing

```hcl
module "sql_server" {
  source = "git::github.com/Nmbrs/tf-modules//azure/sql_server"

  workload            = "analytics"
  company_prefix      = "nmbrs"
  sequence_number     = 1
  resource_group_name = "rg-sql-prod"
  location            = "westeurope"
  environment         = "prod"
  admin_settings = {
    azuread_group_name = "sg-sql-admins"
    local_username     = "sqlcloudadmin"
    local_password_secret = {
      key_vault_id = module.secrets_prod.id
      secret_name  = "sql-admin-password"
    }
  }

  auditing_settings = {
    storage_account_name           = "stnmbrsauditprod"
    storage_account_resource_group = "rg-audit-prod"
  }

  private_endpoint_settings = {
    subnet_id = "/subscriptions/.../subnets/snet-private-endpoints"
    private_dns_zone_ids = {
      sqlServer = module.dns_zone_sql.id
    }
  }
}
```

### SQL Server for development without auditing

```hcl
module "sql_server" {
  source = "git::github.com/Nmbrs/tf-modules//azure/sql_server"

  workload            = "myapp"
  company_prefix      = "nmbrs"
  sequence_number     = 1
  resource_group_name = "rg-sql-dev"
  location            = "westeurope"
  environment         = "dev"
  admin_settings = {
    azuread_group_name = "sg-sql-admins-dev"
    local_username     = "sqladmin"
    local_password_secret = {
      key_vault_id = module.secrets_dev.id
      secret_name  = "sql-admin-password"
    }
  }

  private_endpoint_settings = {
    subnet_id = "/subscriptions/.../subnets/snet-private-endpoints"
    private_dns_zone_ids = {
      sqlServer = module.dns_zone_sql.id
    }
  }
}
```

### SQL Server with public access and VNet rules

Use this variant when the SQL Server must remain reachable from public networks alongside the private endpoint (e.g., legacy clients or managed identities outside the VNet). `firewall_settings.allowed_subnet_ids` creates VNet rules for subnets that should still reach the server over the public endpoint; it is only honoured when `public_network_access_enabled = true`.

```hcl
module "sql_server" {
  source = "git::github.com/Nmbrs/tf-modules//azure/sql_server"

  workload            = "webapp"
  company_prefix      = "nmbrs"
  sequence_number     = 1
  resource_group_name = "rg-sql-prod"
  location            = "westeurope"
  environment         = "prod"
  admin_settings = {
    azuread_group_name = "sg-sql-admins"
    local_username     = "sqlcloudadmin"
    local_password_secret = {
      key_vault_id = module.secrets_prod.id
      secret_name  = "sql-admin-password"
    }
  }

  firewall_settings = {
    public_network_access_enabled = true
    allowed_subnet_ids = [
      "/subscriptions/.../subnets/snet-app-001",
    ]
  }

  auditing_settings = {
    storage_account_name           = "stnmbrsauditprod"
    storage_account_resource_group = "rg-audit-prod"
  }

  private_endpoint_settings = {
    subnet_id = "/subscriptions/.../subnets/snet-private-endpoints"
    private_dns_zone_ids = {
      sqlServer = module.dns_zone_sql.id
    }
  }
}
```

### SQL Server with a custom name override

```hcl
module "sql_server" {
  source = "git::github.com/Nmbrs/tf-modules//azure/sql_server"

  override_name       = "sqls-my-custom-name-001"
  resource_group_name = "rg-sql-prod"
  location            = "westeurope"
  environment         = "prod"
  admin_settings = {
    azuread_group_name = "sg-sql-admins"
    local_username     = "sqlcloudadmin"
    local_password_secret = {
      key_vault_id = module.secrets_prod.id
      secret_name  = "sql-admin-password"
    }
  }

  auditing_settings = {
    storage_account_name           = "stnmbrsauditprod"
    storage_account_resource_group = "rg-audit-prod"
  }

  private_endpoint_settings = {
    subnet_id = "/subscriptions/.../subnets/snet-private-endpoints"
    private_dns_zone_ids = {
      sqlServer = module.dns_zone_sql.id
    }
  }
}
```
