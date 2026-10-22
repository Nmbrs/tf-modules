<!-- BEGIN_TF_DOCS -->
# Key Vault Module

## Summary

The `key_vault` module is an abstraction that implements all the necessary
Terraform code to provision an Azure Keyvault with success, and accordingly with
Visma Nmbrs policies.

The module creates an Azure Keyvault, and custom access policies. Regarding the
access policies, there's always a default access policy that is assigned to the
Terraform Azure service principal, which allows the management of the same
keyvault when need.

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
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.administrators_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.default_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.readers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.writers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | (Optional) Access policies created for the Azure Key Vault. | <pre>list(object({<br/>    name      = string<br/>    object_id = string<br/>    type      = string<br/>  }))</pre> | `[]` | no |
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_external_usage"></a> [external\_usage](#input\_external\_usage) | (Optional) Specifies whether the keyvault should be used internally or externally. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | Network settings for the key vault private endpoint. | <pre>object({<br/>    subnet_name              = string<br/>    vnet_name                = string<br/>    vnet_resource_group_name = string<br/>  })</pre> | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Override the name of the key vault, to bypass naming convention | `string` | `null` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | Resource IDs of the private DNS zones, keyed by subresource. Required keys: `vault` (typically `privatelink.vaultcore.azure.net`). | <pre>object({<br/>    vault = string<br/>  })</pre> | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | A condition to indicate if the Key Vault will have public network access (defaults to false). | `bool` | `false` | no |
| <a name="input_rbac_authorization_enabled"></a> [rbac\_authorization\_enabled](#input\_rbac\_authorization\_enabled) | Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. | `bool` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The Name of the SKU used for this Key Vault Managed HSM. Currently, only 'Standard\_B1' is supported by Azure. | `string` | `"standard"` | no |
| <a name="input_trusted_services_bypass_firewall_enabled"></a> [trusted\_services\_bypass\_firewall\_enabled](#input\_trusted\_services\_bypass\_firewall\_enabled) | Allow trusted Microsoft services to bypass this firewall. When enabled, trusted Microsoft services can access the Key Vault even when network access is restricted. | `bool` | `true` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the key vault. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The key vault ID. |
| <a name="output_name"></a> [name](#output\_name) | The key vault full name. |
| <a name="output_readers_policies"></a> [readers\_policies](#output\_readers\_policies) | List of readers access policies. |
| <a name="output_uri"></a> [uri](#output\_uri) | The URI of the key vault, used for performing operations on keys and secrets. |
| <a name="output_workload"></a> [workload](#output\_workload) | The key vault workload name. |
| <a name="output_writers_policies"></a> [writers\_policies](#output\_writers\_policies) | List of writers access policies. |

## How to use it?

The module always provisions a private endpoint for the key vault (`vault` subresource). Every caller must supply `network_settings` and `private_dns_zone_ids.vault`. The examples below assume the relevant subnet and private DNS zone for `privatelink.vaultcore.azure.net` already exist and are reachable.

### Key Vault using RBAC authorization

```hcl
module "key_vault" {
  source = "git::github.com/Nmbrs/tf-modules//azure/key_vault"

  workload                   = "demo"
  company_prefix             = "nmbrs"
  resource_group_name        = "rg-demo"
  location                   = "westeurope"
  environment                = "dev"
  rbac_authorization_enabled = true

  network_settings = {
    subnet_name              = "snet-private-endpoints"
    vnet_name                = "vnet-myenv"
    vnet_resource_group_name = "rg-networking"
  }

  private_dns_zone_ids = {
    vault = module.dns_zone_vault.id
  }
}
```

### Key Vault using access policies

Access policies are only honoured when `rbac_authorization_enabled = false`.

```hcl
module "key_vault" {
  source = "git::github.com/Nmbrs/tf-modules//azure/key_vault"

  workload                   = "demo"
  company_prefix             = "nmbrs"
  resource_group_name        = "rg-demo"
  location                   = "westeurope"
  environment                = "dev"
  rbac_authorization_enabled = false

  access_policies = [
    {
      name      = "SquadX"
      type      = "readers"
      object_id = "11111111-1111-1111-1111-111111111111"
    },
    {
      name      = "SquadY"
      type      = "writers"
      object_id = "22222222-2222-2222-2222-222222222222"
    },
    {
      name      = "ManagedIdentityZ"
      type      = "writers"
      object_id = "33333333-3333-3333-3333-333333333333"
    },
    {
      name      = "domainW"
      type      = "administrators"
      object_id = "44444444-4444-4444-4444-444444444444"
    },
  ]

  network_settings = {
    subnet_name              = "snet-private-endpoints"
    vnet_name                = "vnet-myenv"
    vnet_resource_group_name = "rg-networking"
  }

  private_dns_zone_ids = {
    vault = module.dns_zone_vault.id
  }
}
```

## Access Policies

Access policies in the context of key vaults define the permissions and actions that can be performed on the key vault's resources, such as keys, secrets, and certificates. They allow you to control who can perform specific operations on these resources.

> Note: The access policies are only available when RBAC authorization is not enabled. This means that if the variable `var.rbac_authorization_enabled` is set to `true`, access policies cannot be used to manage access to key vaults. In this case, RBAC roles should be used to control access

### Access policies types and permissions

The keyvault module supports three types of access policies which will be applied to both secrets and certificates: readers, writers and administrators. The table below indicates which policies have which permissions.

#### Certificates

| Type           | Permissions                                                                                                                                                         |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| writers        | get, list, update, delete                                                                                                                                           |
| readers        | get, list                                                                                                                                                           |
| administrators | backup, create, delete, delete issuers, get, get issuers, import, list, list issuers, manage contacts, manage issuers, purge, recover, restore, set issuers, update |

#### Secrets

| Type           | Permissions                                                     |
| -------------- | --------------------------------------------------------------- |
| writers        | get, list, set, delete                                          |
| readers        | get, list                                                       |
| administrators | backup, create, delete, get, list, purge, recover, restore, set |


### Configuring access policies

To configure the keyvault module to include access policies a list of objects of type `access_policy` is available for this purpose. The policy object contains the following properties:

- name: Name of the security group / user / application / managed identity.
- object_id: Azure AD's unique ID for the desired entity.
- type: type of the desired policy. Valid options are 'readers', 'writers', 'administrators'.

The code below exemplifies how to configure the list of policies

```hcl
  access_policies = [
    # User's policy with readers access
    {
      name      = "User1"
      type      = "readers"
      object_id = "3ad33091-7b7e-4cd9-b53b-6afb2b28347c"
    },
    # Security groups's policy with writers access
    {
      name      = "SecurityGroup1"
      type      = "writers"
      object_id = "6dbf1a02-4950-420a-b115-553d37513bcb"
    },
    # Managed Identity's policy with writers access
    {
      name      = "ManagedIdentityX"
      type      = "writers"
      object_id = "a06cc7dd-c707-42cb-b500-d21ce82ffc05"
    },
    # Applications's policy with readers access
    {
      name      = "Application"
      type      = "writers"
      object_id = "123cad84-b095-41bd-b0fb-683db612121f"
    },
  ]
```
<!-- END_TF_DOCS -->
