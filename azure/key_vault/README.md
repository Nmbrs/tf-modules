# Key Vault Module

## Sumary

The `keyvault` module is an abstraction that implements all the necessary
Terraform code to provision an Azure Keyvault with success, and accordingly with
Visma Nmbrs policies.

The module creates an Azure Keyvault, and custom access policies. Regarding the
access policies, there's always a default access policy that is assigned to the
Terraform Azure service principal, which allows the management of the same
keyvault when need.

## Requirements

| Name                                                                     | Version           |
| ------------------------------------------------------------------------ | ----------------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement_azurecaf)    | 2.0.0-preview3    |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | ~> 3.6            |

## Providers

| Name                                                            | Version         |
| --------------------------------------------------------------- | --------------- |
| <a name="provider_azurecaf"></a> [azurecaf](#provider_azurecaf) | 2.0.0-preview-3 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)    | ~> 3.6          |

## Modules

No modules.

## Resources

| Name                                                                                                                                                      | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [azurecaf_name.caf_name](https://registry.terraform.io/providers/aztfmod/azurecaf/2.0.0-preview3/docs/resources/name)                                     | resource    |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)                                  | resource    |
| [azurerm_key_vault_access_policy.default_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource    |
| [azurerm_key_vault_access_policy.readers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource    |
| [azurerm_key_vault_access_policy.writers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource    |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config)                         | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)                            | data source |

## Inputs

| Name                                                                                       | Description                                                                                        | Type                                                                                        | Default | Required |
| ------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_environment"></a> [environment](#input_environment)                         | The environment in which the resource should be provisioned.                                       | `string`                                                                                    | n/a     |   yes    |
| <a name="input_external_usage"></a> [external_usage](#input_external_usage)                | (Optional) Specifies whether the keyvault should be used internally or externally.                 | `bool`                                                                                      | `true`  |    no    |
| <a name="input_extra_tags"></a> [extra_tags](#input_extra_tags)                            | (Optional) A extra mapping of tags which should be assigned to the desired resource.               | `map(string)`                                                                               | `{}`    |    no    |
| <a name="input_name"></a> [name](#input_name)                                              | The name of the Azure Key Vault.                                                                   | `string`                                                                                    | n/a     |   yes    |
| <a name="input_policies"></a> [policies](#input_policies)                                  | (Optional) Access policies created for the Azure Key Vault.                                        | <pre>list(object({<br> name = string<br> object_id = string<br> type = string<br> }))</pre> | `[]`    |    no    |
| <a name="input_protection_enabled"></a> [protection_enabled](#input_protection_enabled)    | (Optional) Enables the keyvault purge protection in case of accidental deletion. Default is false. | `bool`                                                                                      | `false` |    no    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | The name of an existing Resource Group.                                                            | `string`                                                                                    | n/a     |   yes    |

## Outputs

| Name                                                                                | Description                                                                   |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| <a name="output_id"></a> [id](#output_id)                                           | The Key Vault Key ID.                                                         |
| <a name="output_name"></a> [name](#output_name)                                     | The Key Vault Key name.                                                       |
| <a name="output_readers_policies"></a> [readers_policies](#output_readers_policies) | List of readers access policies.                                              |
| <a name="output_uri"></a> [uri](#output_uri)                                        | The URI of the Key Vault, used for performing operations on keys and secrets. |
| <a name="output_writers_policies"></a> [writers_policies](#output_writers_policies) | List of writers access policies.                                              |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "key_vault" {
  source = "git::github.com/Nmbrs/tf-modules//azure/key_vault"
  name                = "Heimdall"
  environment         = "dev"
  resource_group_name = "rg-heimdall"
  extra_tags = {
    Datadog = "Monitored"
  }

  policies = [
    {
      name      = "SquadX"
      type      = "readers"
      object_id = "objectID"
    },
    {
      name      = "SquadY"
      type      = "writers"
      object_id = "objectID"
    },
    {
      name      = "ManagedIdentityZ"
      type      = "writers"
      object_id = "objectID"
    }
  ]
}
```

## Policies

### Access policies types and permissions

The keyvault module supports two types of access policies which will be applied to both secrets and certificates: readers and writers. The table below indicates which policies have which permissions.

| Type    | Permissions                      |
| ------- | -------------------------------- |
| writers | get, list, write, update, delete |
| readers | get, list                        |

### Configuring policies

To configure the keyvault module to include access policies a list of objects of type policy is available for this purpose.The policy object contains the following properties:

- name: Nome to security group / user / application / managed identity.
- object_id: Azure AD's unique ID for the desired entity.
- type: type of the desired policy. Valid options are 'readers', 'writers'.

The code below exemplifies how to configure the list of policies

```hcl
  policies = [
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
