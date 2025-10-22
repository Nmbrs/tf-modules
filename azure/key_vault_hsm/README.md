<!-- BEGIN_TF_DOCS -->
# Key Vault Managed HSM Module

## Summary

The `key_vault_hsm` module is an abstraction that implements all the necessary Terraform code to provision an Azure Key Vault Managed Hardware Security Module (HSM) with success, and accordingly with Visma Nmbrs policies.

The module creates an Azure Key Vault Managed HSM with admin access controlled through Azure AD security groups. The HSM provides dedicated, single-tenant key management with cryptographic isolation and compliance support for highly sensitive encryption key operations.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | ~> 3.117 |
| <a name="requirement_azuread"></a> [azuread](#requirement_azuread) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 3.117.1 |
| <a name="provider_azuread"></a> [azuread](#provider_azuread) | 2.53.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_managed_hardware_security_module.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_managed_hardware_security_module) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azuread_group.admin_groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_group_names"></a> [admin_group_names](#input_admin_group_names) | List of Azure AD security group names that will have admin access to the Key Vault Managed HSM. | `list(string)` | n/a | yes |
| <a name="input_company_prefix"></a> [company_prefix](#input_company_prefix) | Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters. | `string` | `"nmbrs"` | no |
| <a name="input_environment"></a> [environment](#input_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input_location) | The Azure location where the Key Vault Managed HSM will be deployed. For a list of locations, use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override_name](#input_override_name) | Optional override for the Key Vault Managed HSM name to bypass naming convention. | `string` | `null` | no |
| <a name="input_purge_protection_enabled"></a> [purge_protection_enabled](#input_purge_protection_enabled) | Is Purge Protection enabled for this Key Vault Managed HSM? When enabled, the HSM and its items cannot be permanently deleted. | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | The name of the resource group in which to create the Key Vault Managed HSM. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | The Name of the SKU used for this Key Vault Managed HSM. Currently, only 'Standard_B1' is supported by Azure. | `string` | `"Standard_B1"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft_delete_retention_days](#input_soft_delete_retention_days) | The number of days that items should be retained for soft delete. Must be between 7 and 90 days. | `number` | `90` | no |
| <a name="input_workload"></a> [workload](#input_workload) | The workload name for the Key Vault Managed HSM. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_object_ids"></a> [admin_object_ids](#output_admin_object_ids) | List of Azure AD object IDs that have admin access to the Key Vault Managed HSM. |
| <a name="output_hsm_uri"></a> [hsm_uri](#output_hsm_uri) | The URI of the Key Vault Managed HSM, used for performing operations on keys and secrets. |
| <a name="output_id"></a> [id](#output_id) | The Key Vault Managed HSM resource ID. |
| <a name="output_name"></a> [name](#output_name) | The Key Vault Managed HSM name. |
| <a name="output_workload"></a> [workload](#output_workload) | The workload name used for this Key Vault Managed HSM. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Basic Key Vault Managed HSM with Admin Groups

```hcl
module "key_vault_managed_hsm" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/key_vault_hsm"
  workload            = "crypto"
  resource_group_name = "rg-security-dev"
  environment         = "dev"
  location            = "westeurope"
  company_prefix      = "nmbrs"
  admin_group_names   = ["HSM-Admins", "Security-Team"]
}
```

### Key Vault Managed HSM with Custom Settings

```hcl
module "key_vault_managed_hsm" {
  source                      = "git::github.com/Nmbrs/tf-modules//azure/key_vault_hsm"
  workload                    = "crypto"
  resource_group_name         = "rg-security-prod"
  environment                 = "prod"
  location                    = "eastus"
  company_prefix              = "myorg"
  admin_group_names           = ["HSM-Admins-PROD"]
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
}
```

### Key Vault Managed HSM with Custom Name

```hcl
module "key_vault_managed_hsm" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/key_vault_hsm"
  override_name       = "kvmhsm-custom-prod"
  resource_group_name = "rg-security-prod"
  environment         = "prod"
  location            = "westeurope"
  admin_group_names   = ["Security-Team", "Compliance-Officers"]
}
```

## Admin Groups

The Key Vault Managed HSM module requires specifying Azure AD security groups that will have administrative access to the HSM. These groups are looked up by display name and their object IDs are automatically extracted.

### Admin Access

Admin access grants full permissions to the HSM, including:
- Creating and managing cryptographic keys
- Performing cryptographic operations
- Managing access to the HSM
- Backing up and recovering keys

### Configuring Admin Groups

To configure the Key Vault Managed HSM module to include admin groups, provide a list of Azure AD security group display names via the `admin_group_names` variable.

```hcl
admin_group_names = [
  "Security-Team",
  "HSM-Admins",
  "Compliance-Officers"
]
```

The module will automatically:
- Look up each group by display name in Azure AD
- Validate that the groups exist and are security-enabled
- Extract the object IDs
- Configure them as administrators for the HSM

> **Note**: Security groups must exist in Azure AD before applying this module. The module will fail validation if any group name is not found.

## Naming Convention

The Key Vault Managed HSM follows Azure's recommended naming convention with the prefix `kvmhsm`.

### Naming Format

```
kvmhsm-{company_prefix}-{workload}-{environment}
```

### Example Names

- `kvmhsm-nmbrs-crypto-dev`
- `kvmhsm-nmbrs-crypto-prod`
- `kvmhsm-myorg-keys-test`

To override the automatic naming and use a custom name, use the `override_name` variable.

<!-- END_TF_DOCS -->
