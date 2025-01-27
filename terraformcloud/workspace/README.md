<!-- BEGIN_TF_DOCS -->
# Terraform Cloud Project Module

## Summary

The `workspace` module automates the creation and configuration of workspaces in Terraform Cloud, supporting efficient infrastructure management and workflow integration.

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
| [tfe_workspace.workspace](https://registry.terraform.io/providers/hashicorp/tfe/0.63.0/docs/resources/workspace) | resource |
| [tfe_project.project](https://registry.terraform.io/providers/hashicorp/tfe/0.63.0/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associated_project"></a> [associated\_project](#input\_associated\_project) | Name of the associated project. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the variable set. | `string` | n/a | yes |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | Name of the organization. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "terraformcloud_workspace" {
  source                   = "git::github.com/Nmbrs/tf-modules//terraformcloud/workspace"
  name                     = "my_workspace"
  organization_name        = "my_org"
  associated_project       = "my_project"
}
```
<!-- END_TF_DOCS -->
