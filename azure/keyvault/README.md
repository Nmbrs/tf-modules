# Keyvault Module

## Quick summary

The keyvault module is an abstraction that implements all the necessary
Terraform code to provision an Azure Keyvault with success, and accordingly with
Visma Nmbrs policies.

The module creates an Azure Keyvault, and custom access policies. Regarding the
access policies, there's always a default access policy that is assigned to the
Terraform Azure service principal, which allows the management of the same
keyvault when need.

## How to use it?

Here is a sample that helps illustrating how to user the module on a Terraform service

```hcl
module "keyvault" {
    source = "git"
    name                = "kv-nmbrsheimdall-dev"
    location            = "westeurope"
    resource_group_name = "rg-heimdall-dev"
    tags        = {
        Country : "NL"
        Squad : "Infra"
        Product : "Internal"
        Environment : "Dev"
    }

    writers = ["7574db9b-72f3-431c-b068-b8769935e90c"]
    readers = ["984a10dc-52c5-4e1c-9e91-5215fa5ae26b"]
}
```
### Policies

#### Object ID

The `object_id` property is The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault.

> Note: The object ID must be unique for the list of access policies.

### Permissions

In the following table are the list of permissions for each keyvault type.


| Type         | Permissions   |
| ------------ | ------------- |
| secret       | backup, delete, get, list, purge, recover, restore and set |
| certificate  | backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey |
| key          | backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update  |
| storage      | backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update  |
