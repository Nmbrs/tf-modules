<!-- BEGIN_TF_DOCS -->
# Terraform Cloud Project Module

## Summary

The `project` module facilitates the creation and management of projects in Terraform Cloud, enabling organized grouping and streamlined management of related workspaces.  

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | 0.63.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.63.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_project.project](https://registry.terraform.io/providers/hashicorp/tfe/0.63.0/docs/resources/project) | resource |
| [tfe_project_variable_set.association](https://registry.terraform.io/providers/hashicorp/tfe/0.63.0/docs/resources/project_variable_set) | resource |
| [tfe_variable_set.variable_set](https://registry.terraform.io/providers/hashicorp/tfe/0.63.0/docs/data-sources/variable_set) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associated_variable_sets"></a> [associated\_variable\_sets](#input\_associated\_variable\_sets) | List of variable sets associated to the project. | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the variable set. | `string` | n/a | yes |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | Name of the organization. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "terraformcloud_project" {
  source                   = "git::github.com/Nmbrs/tf-modules//terraformcloud/project"
  name                     = "my_project"
  organization_name        = "my_org"
  associated_variable_sets =  [ "varset1","varset2" ]
}
```
<!-- END_TF_DOCS -->
