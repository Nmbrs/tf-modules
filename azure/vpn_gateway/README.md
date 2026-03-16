# VPN Gateway Module

## Summary

The `vpn_gateway` module is a Terraform module that provides a convenient way to create Virtual gateways in Azure to use as VPN. The module includes all necessary configurations to provision and manage the Virtual gateway, including vnet, subnet, and SKU. The module creates a vpn gateway using AAD authentication
The module ensures compliance with specified policies and implements the Terraform code to provision Virtual gateway with ease, making it an ideal solution for those who want to streamline Nmbrs network infrastructure.

> Note: Before you create a VPN gateway, you must create a gateway subnet. The gateway subnet contains the IP addresses that the virtual network gateway VMs and services use. When you create your virtual network gateway, gateway VMs are deployed to the gateway subnet and configured with the required VPN gateway settings. Never deploy anything else (for example, additional VMs) to the gateway subnet. The gateway subnet must be named ‘GatewaySubnet’ to work properly. Naming the gateway subnet ‘GatewaySubnet’ lets Azure know that this is the subnet to which it should deploy the virtual network gateway VMs and services.

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
| [azurerm_public_ip.vpn_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_network_gateway.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company / organization. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | Settings related to the network connectivity of the VPN gateway. | <pre>object({<br/>    vnet_name                = string<br/>    vnet_resource_group_name = string<br/>    address_spaces           = optional(list(string), [])<br/>  })</pre> | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the resource group where the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_sequence_number"></a> [sequence\_number](#input\_sequence\_number) | A numeric value used to ensure uniqueness for resource names. | `number` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Configuration of the size and capacity of the virtual network gateway. | `string` | `"VpnGw1"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | Short, descriptive name for the application, service, or workload. Used in resource naming conventions. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The VPN gateway ID. |
| <a name="output_name"></a> [name](#output\_name) | The VPN gateway full name. |
| <a name="output_workload"></a> [workload](#output\_workload) | The VPN gateway workload. |
<!-- END_TF_DOCS -->
## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### VPN Gateway with default SKU

```hcl
module "vpn_gateway" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/vpn_gateway"
  workload            = "corp"
  company_prefix      = "nmbrs"
  sequence_number     = 1
  environment         = "prod"
  location            = "westeurope"
  resource_group_name = "rg-networks-prod"

  network_settings = {
    vnet_name                = "vnet-vpn-prod-westeurope-001"
    vnet_resource_group_name = "rg-networks-prod"
    address_spaces           = ["172.25.0.0/24"]
  }
}
```

### VPN Gateway with a higher SKU

```hcl
module "vpn_gateway" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/vpn_gateway"
  workload            = "corp"
  company_prefix      = "nmbrs"
  sequence_number     = 1
  environment         = "prod"
  location            = "westeurope"
  resource_group_name = "rg-networks-prod"
  sku_name            = "VpnGw3AZ"

  network_settings = {
    vnet_name                = "vnet-vpn-prod-westeurope-001"
    vnet_resource_group_name = "rg-networks-prod"
    address_spaces           = ["172.25.0.0/24"]
  }
}
```

### VPN Gateway with a custom name override

```hcl
module "vpn_gateway" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/vpn_gateway"
  override_name       = "my-custom-vpng-name"
  environment         = "prod"
  location            = "westeurope"
  resource_group_name = "rg-networks-prod"

  network_settings = {
    vnet_name                = "vnet-vpn-prod-westeurope-001"
    vnet_resource_group_name = "rg-networks-prod"
    address_spaces           = ["172.25.0.0/24"]
  }
}
```
