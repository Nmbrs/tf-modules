# Azure Dev Ops Project Module

## Sumary

The `virtual_network` module supports the creation of Microsoft Azure virtual network in an existent Azure resource group name. This module also supports
the creation of vnet subnets and enables the vnet service delegation, when needed.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | ~> 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | ~> 1.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuredevops_check_approval.prod_environment](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/check_approval) | resource |
| [azuredevops_check_approval.sand_environment](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/check_approval) | resource |
| [azuredevops_check_approval.test_environment](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/check_approval) | resource |
| [azuredevops_environment.dev](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/environment) | resource |
| [azuredevops_environment.prod](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/environment) | resource |
| [azuredevops_environment.sand](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/environment) | resource |
| [azuredevops_environment.test](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/environment) | resource |
| [azuredevops_group_membership.project_administrators](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/group_membership) | resource |
| [azuredevops_group_membership.project_default_team_membership](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/group_membership) | resource |
| [azuredevops_group_membership.readers](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/group_membership) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/project) | resource |
| [azuredevops_group.aad_administrators](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |
| [azuredevops_group.aad_contributors](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |
| [azuredevops_group.aad_readers](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |
| [azuredevops_group.contributors](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |
| [azuredevops_group.project_administrators](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |
| [azuredevops_group.project_default_team](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |
| [azuredevops_group.readers](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_administrators"></a> [group\_administrators](#input\_group\_administrators) | Group that will be the administrator at the Azure DevOps project | `string` | n/a | yes |
| <a name="input_group_contributors"></a> [group\_contributors](#input\_group\_contributors) | Group that will be the contributor at the Azure DevOps project | `string` | n/a | yes |
| <a name="input_group_readers"></a> [group\_readers](#input\_group\_readers) | Group that will be the readers at the Azure DevOps project | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Azure Dev Ops project | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "azuredevops_project" {
  source                = "git::github.com/Nmbrs/tf-modules//azuredevops/project"
  name                  = "internaltools"
  group_owners          = "sg-owners"
  group_administrators  = "sg-domain-infra
  group_readers         = "sg-developers
}
```
