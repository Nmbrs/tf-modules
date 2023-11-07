# VPN Gateway Module

## Summary

The `vpn_gateway` module is a Terraform module that provides a convenient way to create Virtual gateways in Azure to use as VPN. The module includes all necessary configurations to provision and manage the Virtual gateway, including vnet, subnet, and SKU. The module creates a vpn gateway using AAD authentication
The module ensures compliance with specified policies and implements the Terraform code to provision Virtual gateway with ease, making it an ideal solution for those who want to streamline Nmbrs network infrastructure.

> Note: Before you create a VPN gateway, you must create a gateway subnet. The gateway subnet contains the IP addresses that the virtual network gateway VMs and services use. When you create your virtual network gateway, gateway VMs are deployed to the gateway subnet and configured with the required VPN gateway settings. Never deploy anything else (for example, additional VMs) to the gateway subnet. The gateway subnet must be named ‘GatewaySubnet’ to work properly. Naming the gateway subnet ‘GatewaySubnet’ lets Azure know that this is the subnet to which it should deploy the virtual network gateway VMs and services.

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
| [azurerm_public_ip.vpn_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_network_gateway.vpn_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_spaces"></a> [address\_spaces](#input\_address\_spaces) | The address space out of which IP addresses for vpn clients will be taken. You can provide more than one address space, e.g. in CIDR notation | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Defines the environment to provision the resources. | `string` | n/a | yes |
| <a name="input_generation"></a> [generation](#input\_generation) | The Generation of the Virtual Network gateway. | `string` | `"Generation1"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | n/a | `number` | `1` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name for where the virtual gateway will be created | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Configuration of the size and capacity of the virtual network gateway. | `string` | `"VpnGw1"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the Vnet that will be added to the virtual gateway | `string` | n/a | yes |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | Resource group of the Vnet that will be added to the virtual gateway | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the virtual gateway. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The VPN gateway ID. |
| <a name="output_name"></a> [name](#output\_name) | The VPN gateway full name. |
| <a name="output_workload"></a> [workload](#output\_workload) | The VPN gateway workload. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## Virtual Gateway

```hcl
module "vpn_gateway" {
  source                   = "git::github.com/Nmbrs/tf-modules//azure/vpn_gateway?ref=main"
  workload                 = "testvpn"
  instance_count           = 1
  environment              = "dev"
  location                 = "westeurope"
  resource_group_name      = rg-virtualgateway
  vnet_name                = "vnet-myvnet-dev-001"
  vnet_resource_group_name = "rg-vnet"
  address_spaces = ["10.2.0.0/24"]
}
```
