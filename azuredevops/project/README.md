<!-- BEGIN_TF_DOCS -->
# Azure Dev Ops Project Module

## Sumary

The `azuredevops_project` module simplifies the creation and configuration of Azure DevOps projects. It enables the setup of core project settings, such as repositories, pipelines, and service connections, while integrating with existing Azure DevOps organizations.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | ~> 1.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | ~> 1.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuredevops_check_approval.prod_environment](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/check_approval) | resource |
| [azuredevops_check_approval.sand_environment](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/check_approval) | resource |
| [azuredevops_check_approval.stage_environment](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/check_approval) | resource |
| [azuredevops_check_approval.test_environment](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/check_approval) | resource |
| [azuredevops_environment.dev](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/environment) | resource |
| [azuredevops_environment.prod](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/environment) | resource |
| [azuredevops_environment.sand](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/environment) | resource |
| [azuredevops_environment.stage](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/environment) | resource |
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
| <a name="input_administrators_groups"></a> [administrators\_groups](#input\_administrators\_groups) | List of groups that will be administrators at the Azure DevOps project | `list(string)` | n/a | yes |
| <a name="input_contributors_groups"></a> [contributors\_groups](#input\_contributors\_groups) | List of groups that will be contributors at the Azure DevOps project | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Azure Dev Ops project | `string` | n/a | yes |
| <a name="input_readers_groups"></a> [readers\_groups](#input\_readers\_groups) | List of groups that will be readers at the Azure DevOps project | `list(string)` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "azuredevops_project" {
  source                = "git::github.com/Nmbrs/tf-modules//azuredevops/project"
  name                  = "internaltools"
  group_owners          = ["sg-owners"]
  group_administrators  = ["sg-domain-admin]
  group_readers         = ["sg-all-developers"]
}
```
<!-- END_TF_DOCS -->
