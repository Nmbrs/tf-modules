# Azure Keyvault Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

---

The keyvault module is an abstraction that implements all the necessary
Terraform code to provision an Azure Keyvault with success, and accordingly with
Visma Nmbrs policies.

The module creates an Azure Keyvault, and custom access policies. Regarding the
access policies, there's always a default access policy that is assigned to the
Terraform Azure service principal, which allows the management of the same
keyvault when need.

## Module Input variables

- `name` - name of the Azure resource group to be created.
- `resource_group_name` - Specifies the Azure resource group where the keyvault will be created.
- `environment` - (Optional) The environment in which the resource should be provisioned.
- `external_usage` - (Optional) Specifies whether the keyvault is for internal or external use. Default value is `true`.
- `extra_tags` - List of mandatory resource tags.
- `protection_enabled` - (Optional) Enables the keyvault purge protection in case of accidental deletion. Default is false.
- `policies` - (Optional) Access policies created for the Azure Key Vault. For more information see the [policies](#policies) section.

## Module Output Variables

- `name` - Azure Keyvault name
- `id` - Azure keyvault ID
- `uri` - Azure Keyvault URI

## How to use it?

Here is a sample that helps illustrating how to user the module on a Terraform service

```hcl
module "keyvault" {
  source = "git::github.com/Nmbrs/tf-modules//azure/keyvault"
  name                = "Heimdall"
  environment         = "Dev"
  resource_group_name = "rg-heimdall-dev"
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
