# Resource Group Module

## Sumary

The resource_group module is an abstraction that handle the creation and management of resource groups in Azure.

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
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_category"></a> [category](#input\_category) | (Optional) High-level identification name that supports product components. | `string` | `"not_applicable"` | no |
| <a name="input_country"></a> [country](#input\_country) | (Optional) Name of the country to which the resources belongs. | `string` | `"global"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | (Optional) A extra mapping of tags which should be assigned to the desired resource. | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the resource group. It must follow the CAF naming convention. | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | (Optional) Name of the owner to which the resource belongs. | `string` | `"not_applicable"` | no |
| <a name="input_product"></a> [product](#input\_product) | (Optional) Name of the product to which the resource belongs. | `string` | `"not_applicable"` | no |
| <a name="input_status"></a> [status](#input\_status) | (Optional) Indicates the resource state that can lead to post actions (either manually or automatically). | `string` | `"life_cycle"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Resource Group. |
| <a name="output_location"></a> [location](#output\_location) | The Azure Region where the Resource Group exists. |
| <a name="output_name"></a> [name](#output\_name) | The Resource Group name. |
| <a name="output_tags"></a> [tags](#output\_tags) | A mapping of tags assigned to the Resource Group. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "resource-group" {
  source                    = "git::github.com/Nmbrs/tf-modules//azure/resource_group"
  name                      = "my_project"
  location                  = "westeurope"
  environment               = "dev"
  product                   = "internal"
  category                  = "monolith"
  owner                     = "infra"
  country                   = "nl"
  extra_tags = {
    datadog = "monitored"
  }
}
```
