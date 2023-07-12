# Virtual Network Module

## Sumary

The `virtual_network` module supports the creation of Microsoft Azure virtual network in an existent Azure resource group name. This module also supports
the creation of vnet subnets and enables the vnet service delegation, when needed.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.64.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.vnet_destiny](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.vnet_source](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_virtual_network.vnet_destiny](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_spaces"></a> [address\_spaces](#input\_address\_spaces) | The address space that is used the virtual network. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the virtual network. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of objects that represent the configuration of each subnet. | <pre>list(object({<br>    name                                          = string<br>    address_prefixes                              = list(string)<br>    delegations                                   = list(string)<br>    private_link_service_network_policies_enabled = bool<br>    private_endpoint_network_policies_enabled     = bool<br>    service_endpoints                             = list(string)<br><br>  }))</pre> | `[]` | no |
| <a name="input_vnet_peerings"></a> [vnet\_peerings](#input\_vnet\_peerings) | List of objects that represent the configuration of each vnet peering. | <pre>list(object({<br>    vnet_name                    = string<br>    vnet_resource_group_name     = string<br>    use_remote_gateways          = bool<br>    allow_forwarded_traffic      = bool<br>    allow_gateway_transit        = bool<br>    allow_virtual_network_access = bool<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Specifies the resource id of the virtual network |
| <a name="output_name"></a> [name](#output\_name) | Specifies the name of the virtual network |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Contains a list of the the resource id of the subnets |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Contains a list of the subnets data |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## Adding subnets

```hcl
module "virtual_network" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/virtual_network"
  resource_group_name = "rg-vnet-01"
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

## Virtual network peering

```hcl
module "virtual_network" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/virtual_network"
  resource_group_name = "rg-vnet-02"
  name                = "vnet-dev-westeu-2000"
  address_spaces      = ["10.151.0.0/16"]
  environment         = "dev"
  vnet_peerings = [
    {
      vnet_name                    = "vnet-dev-westeu-1000"
      vnet_resource_group_name     = "rg-vnet-01"
      use_remote_gateways          = true
      allow_forwarded_traffic      = true
      allow_gateway_transit        = true
      allow_virtual_network_access = true
    }
  ]
}
```
