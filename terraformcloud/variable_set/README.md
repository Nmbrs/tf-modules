<!-- BEGIN_TF_DOCS -->
## Terraform Cloud Variable Set

The `variable_set` module automates the creation and management of variable sets in Terraform Cloud, allowing for streamlined configuration and reuse of variables across multiple workspaces.

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
| [tfe_variable_set.variable_sets](https://registry.terraform.io/providers/hashicorp/tfe/0.63.0/docs/resources/variable_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the variable set. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the variable set. | `string` | n/a | yes |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | Name of the organization. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "terraformcloud_variable_set" {
  source                = "git::github.com/Nmbrs/tf-modules//terraformcloud/variable_set"
  name                  = "my_vset"
  organization_name     = "myorg"
  associated_project    = "myprojec"
}
```
<!-- END_TF_DOCS -->
