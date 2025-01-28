<!-- BEGIN_TF_DOCS -->
# Terraform Cloud Organization

## Summary

The `organization` module manages the creation and configuration of organizations in Terraform Cloud, enabling centralized governance and collaboration across workspaces.

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
| [tfe_organization.organization](https://registry.terraform.io/providers/hashicorp/tfe/0.63.0/docs/resources/organization) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_email"></a> [admin\_email](#input\_admin\_email) | Admin email address. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the organization. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "terraformcloud_organization" {
  source                = "git::github.com/Nmbrs/tf-modules//terraformcloud/organization"
  name                  = "my_org"
  admin_email           = "mail@myorg.com"
}
```
<!-- END_TF_DOCS -->