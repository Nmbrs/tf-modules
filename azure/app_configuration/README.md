# Azure App Configuration Terraform Module

## Summary

This module provisions an Azure App Configuration resource with secure-by-default settings, standardized naming, and input validation. It is designed for composable use in larger infrastructure deployments and follows repository-wide conventions for variables and naming logic.

<!-- BEGIN_TF_DOCS -->
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
| [azurerm_app_configuration.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company / organization. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | A condition to indicate if the App Configuration will have public network access (defaults to false). | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the resource group where the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of the App Configuration. | `string` | `"developer"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | Short, descriptive name for the application, service, or workload. Used in resource naming conventions. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint used to access the App Configuration. |
| <a name="output_id"></a> [id](#output\_id) | The App Configuration ID. |
| <a name="output_name"></a> [name](#output\_name) | The App Configuration full name. |
| <a name="output_workload"></a> [workload](#output\_workload) | The App Configuration workload. |
<!-- END_TF_DOCS -->

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### App Configuration at free tier

```hcl
module "app_configuration" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/app_configuration"
  workload            = "myapp"
  company_prefix      = "nmbrs"
  resource_group_name = "rg-apps"
  location            = "westeurope"
  environment         = "dev"
  sku_name            = "free"
}
```

### App Configuration at standard tier with public network access

```hcl
module "app_configuration" {
  source                        = "git::github.com/Nmbrs/tf-modules//azure/app_configuration"
  workload                      = "myapp"
  company_prefix                = "nmbrs"
  resource_group_name           = "rg-apps"
  location                      = "westeurope"
  environment                   = "prod"
  sku_name                      = "standard"
  public_network_access_enabled = true
}
```

### App Configuration with a custom name override

```hcl
module "app_configuration" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/app_configuration"
  override_name       = "my-custom-appcs-name"
  resource_group_name = "rg-apps"
  location            = "westeurope"
  environment         = "prod"
}
```
