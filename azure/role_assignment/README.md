<!-- BEGIN_TF_DOCS -->
# Role Assignment Module

## Summary

The `role_assignment` module enables the assignment of one or multiple roles to service principals, managed identities, security groups, or users, simplifying access control and permission management in Azure.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.0.2 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_group.security_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.managed_identity](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.service_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.user](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_principal_name"></a> [principal\_name](#input\_principal\_name) | The name of the principal to assign roles to. | `string` | n/a | yes |
| <a name="input_principal_type"></a> [principal\_type](#input\_principal\_type) | The type of pricipal to which roles will be assigned. | `string` | n/a | yes |
| <a name="input_resources"></a> [resources](#input\_resources) | A list of resources with their details, including name, type, ID, resource group name, and roles. | <pre>list(object({<br/>    id                  = optional(string, null)<br/>    roles               = list(string)<br/>  }))</pre> | `[]` | no |

## Outputs

No outputs.

## How to use it?

To help you get started, we’ve included code snippets showcasing various use cases for this module.

### Assigning roles to a service principal

```hcl
module "role_assignments" {
  source          = "git::github.com/Nmbrs/tf-modules//azure/role_assignments"
  principal_type  = "service_principal"
  principal_name  = "my-service-principal"
  resources = [
    {
      id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-resource-group/providers/Microsoft.Storage/storageAccounts/mystorageaccount"
      roles = ["Storage Blob Data Contributor", "Reader"]
    },
    {
      id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/another-resource-group/providers/Microsoft.KeyVault/vaults/mykeyvault"
      roles = ["Key Vault Secrets User"]
    }
  ]
}

```

### Assigning roles to a security group

```hcl
module "role_assignments" {
  source          = "git::github.com/Nmbrs/tf-modules//azure/role_assignments"
  principal_type  = "security_group"
  principal_name  = "my-security-group"
  resources = [
    {
      id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/secure-resource-group/providers/Microsoft.Compute/virtualMachines/myvm"
      roles = ["Virtual Machine Contributor"]
    }
  ]
}
```

### Assigning roles to a managed identity
```hcl
module "role_assignments" {
  source          = "git::github.com/Nmbrs/tf-modules//azure/role_assignments"
  principal_type  = "managed_identity"
  principal_name  = "my-managed-identity"
  resources = [
    {
      id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/identity-resource-group/providers/Microsoft.Storage/storageAccounts/identityStorage"
      roles = ["Storage Account Contributor"]
    }
  ]
}
```
<!-- END_TF_DOCS -->
