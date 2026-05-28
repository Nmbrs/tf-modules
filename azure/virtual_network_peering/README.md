# Virtual Network Peering Module

## Sumary

The `virtual_network_peering` module supports the connection between two or more Virtual Networks in Azure. The virtual networks appear as one for connectivity purposes. The traffic between hosts in peered virtual networks uses the Microsoft backbone infrastructure. Like traffic between virtual machines in the same network, traffic is routed through Microsoft's private network only.

The module supports peering VNets that live in the **same subscription** or in **different subscriptions**. It declares two required provider configuration aliases — `azurerm.source` and `azurerm.destination` — so each side of the peering is created with credentials scoped to the subscription that owns the corresponding VNet. For same-subscription peerings, point both aliases at the same provider.

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

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Same-subscription peering

Wire both `azurerm.source` and `azurerm.destination` to the default `azurerm` provider.

```hcl
module "virtual_network_peering" {
  source = "git::github.com/Nmbrs/tf-modules//azure/virtual_network_peering"

  providers = {
    azurerm.source      = azurerm
    azurerm.destination = azurerm
  }

  vnet_source = {
    name                         = "vnet-dev-westeu-1000"
    resource_group_name          = "rg-vnet-01"
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    allow_virtual_network_access = true
    use_remote_gateways          = true
  }
  vnet_destination = {
    name                         = "vnet-dev-westeu-1001"
    resource_group_name          = "rg-vnet-01"
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    allow_virtual_network_access = true
    use_remote_gateways          = false
  }
}
```

### Cross-subscription peering

Declare a second `azurerm` provider aliased to the remote subscription, then pass each provider to the matching module alias.

```hcl
provider "azurerm" {
  features {}
  # default provider — source VNet's subscription
}

provider "azurerm" {
  alias           = "hub"
  subscription_id = "00000000-0000-0000-0000-000000000000"
  features {}
}

module "virtual_network_peering" {
  source = "git::github.com/Nmbrs/tf-modules//azure/virtual_network_peering"

  providers = {
    azurerm.source      = azurerm
    azurerm.destination = azurerm.hub
  }

  vnet_source = {
    name                         = "vnet-spoke-dev-westeu-001"
    resource_group_name          = "rg-networks-dev"
    allow_forwarded_traffic      = true
    allow_gateway_transit        = false
    allow_virtual_network_access = true
    use_remote_gateways          = true
  }
  vnet_destination = {
    name                         = "vnet-hub-westeu-001"
    resource_group_name          = "rg-we-networking"
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    allow_virtual_network_access = true
    use_remote_gateways          = false
  }
}
```
