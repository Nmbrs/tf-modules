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

    writers = ["some_security_group_name", "some_security_group_name"]
    readers = ["some_security_group_name", "some_security_group_name", "some_security_group_name"]
}
```
## Policies

### Permissions

There're only two access policies: readers and writers, that will be applied to both secrets and certificates.

| Type         | Permissions                      |
| ------------ | -------------------------------- |
| writers      | get, list, write, update, delete |
| readers      | get, list                        |
