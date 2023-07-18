# Virtual Network Peering Module

## Sumary

The `virtual_network_peering` module supports the connection between two or more Virtual Networks in Azure. The virtual networks appear as one for connectivity purposes. The traffic between hosts in peered virtual networks uses the Microsoft backbone infrastructure. Like traffic between virtual machines in the same network, traffic is routed through Microsoft's private network only.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network_peering.vnet_destnation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.vnet_source](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network.vnet_destination](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [azurerm_virtual_network.vnet_source](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vnet_destination"></a> [vnet\_destination](#input\_vnet\_destination) | object that represent the configuration of the destination vnet to be peered. | <pre>object({<br>    name                         = string<br>    resource_group_name          = string<br>    allow_forwarded_traffic      = bool<br>    allow_gateway_transit        = bool<br>    allow_virtual_network_access = bool<br>    use_remote_gateways          = bool<br>  })</pre> | n/a | yes |
| <a name="input_vnet_source"></a> [vnet\_source](#input\_vnet\_source) | object that represent the configuration of the source vnet to be peered. | <pre>object({<br>    name                         = string<br>    resource_group_name          = string<br>    allow_forwarded_traffic      = bool<br>    allow_gateway_transit        = bool<br>    allow_virtual_network_access = bool<br>    use_remote_gateways          = bool<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
