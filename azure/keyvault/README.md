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

```hcl
module "keyvault" {
    source = "git"
    name                = "kv-heimdall-dev"
    location            = "westeurope"
    resource_group_name = "rg-heimdall-dev"
    tags        = {
        Country : "nl"
        Squad : "infra"
        Product : "internal"
        Environment : "dev"
    }

    policies = {
        squad_infra = {
            object_id = "7574db9b-72f3-431c-b068-b8769935e90c"
            key_permissions         = ["get", "list"]
            secret_permissions      = ["get", "list"]
            certificate_permissions = ["get", "list"]
            storage_permissions     = ["get", "list"]
        }
    
    }
}
```



