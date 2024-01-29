# Managed Identity Module

## Summary 

The `managed_identity` module is a Terraform module that provides allows the creation, configuration, and association of user assigned identities with other Azure resources, offering flexibility in identity management.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.70 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_user_assigned_identity.identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Defines the environment to provision the resources. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name for where the resource will be created | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | This variable defines the name of the resource. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The ID of the app associated with the identity. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the User Assigned Identity. |
| <a name="output_name"></a> [name](#output\_name) | The identity full name. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The ID of the Service Principal object associated with the created identity. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The ID of the Tenant which the identity belongs to. |
| <a name="output_workload"></a> [workload](#output\_workload) | The identity workload name. |

## How to use it? 

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform. 

## Managed Identity

```hcl 
module "managed_identity" { 
    source                   = "git::github.com/Nmbrs/tf-modules//azure/managed_identity"
    workload                 = "myapp"
    resource_group_name      = "rg-myrg-dev"
    environment              = "dev"
    location                 = "westeurope"
    } 
```