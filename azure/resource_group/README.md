# Resource Group Module

## Sumary

The resource_group module is an abstraction that handle the creation and management of resource groups in Azure.

## Requirements

| Name                                                                     | Version           |
| ------------------------------------------------------------------------ | ----------------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement_azurecaf)    | 2.0.0-preview3    |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | ~> 3.6            |

## Providers

| Name                                                            | Version         |
| --------------------------------------------------------------- | --------------- |
| <a name="provider_azurecaf"></a> [azurecaf](#provider_azurecaf) | 2.0.0-preview-3 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm)    | 3.16.0          |

## Modules

No modules.

## Resources

| Name                                                                                                                        | Type     |
| --------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurecaf_name.caf_name](https://registry.terraform.io/providers/aztfmod/azurecaf/2.0.0-preview3/docs/resources/name)       | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name                                                               | Description                                                                                                                                                  | Type          | Default            | Required |
| ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | ------------------ | :------: |
| <a name="input_category"></a> [category](#input_category)          | (Optional) High-level identification name that supports product components.                                                                                  | `string`      | `"not_applicable"` |    no    |
| <a name="input_country"></a> [country](#input_country)             | (Optional) Name of the country to which the resources belongs.                                                                                               | `string`      | `"global"`         |    no    |
| <a name="input_environment"></a> [environment](#input_environment) | The environment in which the resource should be provisioned.                                                                                                 | `string`      | n/a                |   yes    |
| <a name="input_extra_tags"></a> [extra_tags](#input_extra_tags)    | (Optional) A extra mapping of tags which should be assigned to the desired resource.                                                                         | `map(string)` | `{}`               |    no    |
| <a name="input_location"></a> [location](#input_location)          | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string`      | n/a                |   yes    |
| <a name="input_name"></a> [name](#input_name)                      | Name of the resource group. It must follow the CAF naming convention.                                                                                        | `string`      | n/a                |   yes    |
| <a name="input_owner"></a> [owner](#input_owner)                   | (Optional) Name of the owner to which the resource belongs.                                                                                                  | `string`      | `"not_applicable"` |    no    |
| <a name="input_product"></a> [product](#input_product)             | (Optional) Name of the product to which the resource belongs.                                                                                                | `string`      | `"not_applicable"` |    no    |
| <a name="input_status"></a> [status](#input_status)                | (Optional) Indicates the resource state that can lead to post actions (either manually or automatically).                                                    | `string`      | `"life_cycle"`     |    no    |

## Outputs

| Name                                                        | Description                                       |
| ----------------------------------------------------------- | ------------------------------------------------- |
| <a name="output_id"></a> [id](#output_id)                   | The ID of the Resource Group.                     |
| <a name="output_location"></a> [location](#output_location) | The Azure Region where the Resource Group exists. |
| <a name="output_name"></a> [name](#output_name)             | The Resource Group name.                          |
| <a name="output_tags"></a> [tags](#output_tags)             | A mapping of tags assigned to the Resource Group. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "resource-group" {
  source                    = "git::github.com/Nmbrs/tf-modules//azure/resource-group"
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
