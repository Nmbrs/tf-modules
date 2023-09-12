# NAT gateway Module 

## Summary 

The NAT Gateway module is a Terraform module that provides a convenient way to create NAT gateways in Azure. The module includes all necessary configurations to provision and manage the NAT gateway, including vnet, subnet, and SKU. The module ensures compliance with specified policies and implements the Terraform code to provision NAT gateway with ease, making it an ideal solution for those who want to streamline Nmbrs network infrastructure.

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
| [azurerm_nat_gateway.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_public_ip.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet_nat_gateway_association.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Defines the environment to provision the resources. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | This variable defines the name of the NAT gateway. | `string` | n/a | yes |
| <a name="input_name_sequence_number"></a> [name\_sequence\_number](#input\_name\_sequence\_number) | A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance in the naming convention. | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets to be included in the NAT gateway | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the Vnet that will be added to the NAT gateway | `string` | n/a | yes |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | Resource group of the Vnet that will be added to the NAT gateway | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | Output of the public IP |

## How to use it? 

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform. 

## NAT Gateway 

```hcl 
module "nat_gateway" { 
    source                   = "git::github.com/Nmbrs/tf-modules//azure/nat_gateway"
    name                     = "myapp"
    name_sequence_number     = 1
    vnet_resource_group_name = "rg-myrg-dev"
    vnet_name                = "vnet-westeu-001-dev"
    subnets                  = ["default","internal"]
    resource_group_name      = "rg-network"
    environment              = "dev"
    location                 = "westeurope"
    } 
```
