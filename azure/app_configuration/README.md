<!-- BEGIN_TF_DOCS -->
# Azure App Configuration Terraform Module

## Summary

This module provisions an Azure App Configuration resource with secure-by-default settings, standardized naming, and input validation. It is designed for composable use in larger infrastructure deployments and follows repository-wide conventions for variables and naming logic.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_configuration.app_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters. | `string` | `"nmbrs"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Override the name of the App Configuration, to bypass naming convention. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | A condition to indicate if the App Configuration will have public network access (defaults to false). | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of the App Configuration. Possible values are 'free', 'standard', and 'premium'. Defaults to 'free'. | `string` | `"free"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the App Configuration. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### App configuration at free tier

```hcl
module "app_configuration" {
  source              = "./azure/app_configuration"
  workload            = "myapp"
  company_prefix      = "nmbrs"
  resource_group_name = "rg-apps"
  location            = "westeurope"
  environment         = "dev"
  sku_name            = "free"
}
```
<!-- END_TF_DOCS -->
