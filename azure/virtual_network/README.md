# Virtual Network Module

## Sumary

The `virtual_network` module supports the creation of Microsoft Azure virtual network in an existent Azure resource group name. This module also supports
the creation of vnet subnets and enables the vnet service delegation, when needed.

## Requirements

| Name                                                                     | Version           |
| ------------------------------------------------------------------------ | ----------------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement_azurecaf)    | 2.0.0-preview3    |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | ~> 3.6            |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 3.6.0   |

## Modules

No modules.

## Resources

| Name                                                                                                                              | Type        |
| --------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                   | resource    |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)   | resource    |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)    | data source |

## Inputs

| Name                                                                                       | Description                                                                          | Type                                                                                                                                                                                                                                                                         | Default | Required |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_address_spaces"></a> [address_spaces](#input_address_spaces)                | The address space that is used the virtual network.                                  | `list(string)`                                                                                                                                                                                                                                                               | `[]`    |    no    |
| <a name="input_environment"></a> [environment](#input_environment)                         | The environment in which the resource should be provisioned.                         | `string`                                                                                                                                                                                                                                                                     | n/a     |   yes    |
| <a name="input_extra_tags"></a> [extra_tags](#input_extra_tags)                            | (Optional) A extra mapping of tags which should be assigned to the desired resource. | `map(string)`                                                                                                                                                                                                                                                                | `{}`    |    no    |
| <a name="input_name"></a> [name](#input_name)                                              | The name of the virtual network.                                                     | `string`                                                                                                                                                                                                                                                                     | n/a     |   yes    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | The name of the resource group in which to create the virtual network.               | `string`                                                                                                                                                                                                                                                                     | n/a     |   yes    |
| <a name="input_subnets"></a> [subnets](#input_subnets)                                     | List of objects that represent the configuration of each subnet.                     | <pre>list(object({<br> name = string<br> address_prefixes = list(string)<br> delegations = list(string)<br> private_link_service_network_policies_enabled = bool<br> private_endpoint_network_policies_enabled = bool<br> service_endpoints = list(string)<br><br> }))</pre> | `[]`    |    no    |

## Outputs

| Name                                                              | Description                                           |
| ----------------------------------------------------------------- | ----------------------------------------------------- |
| <a name="output_id"></a> [id](#output_id)                         | Specifies the resource id of the virtual network      |
| <a name="output_name"></a> [name](#output_name)                   | Specifies the name of the virtual network             |
| <a name="output_subnet_ids"></a> [subnet_ids](#output_subnet_ids) | Contains a list of the the resource id of the subnets |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "virtual_network" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/virtual_network"
  resource_group_name = module.rg-01.name
  name                = "vnet-dev-westeu-1000"
  address_spaces      = ["10.150.0.0/16"]
  environment         = "dev"
  subnets = [
    {
      name                                           = "snet-dev-westeu-1000"
      address_prefixes                               = ["10.150.100.0/24"]
      delegations                                    = ["Microsoft.ContainerInstance/containerGroups", "Microsoft.Web/serverFarms", "Microsoft.Databricks/workspaces"]
      private_link_service_network_policies_enabled  = false
      private_endpoint_network_policies_enabled      = false
      service_endpoints                              = ["Microsoft.EventHub", "Microsoft.Web", "Microsoft.Sql"]
    }
  ]
}
```
