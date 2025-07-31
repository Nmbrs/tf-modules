<!-- BEGIN_TF_DOCS -->
# NAT gateway Module

## Summary

The `nat_gateway` module is a Terraform module that provides a convenient way to create NAT gateways in Azure. The module includes all necessary configurations to provision and manage the NAT gateway, including network connectivity settings and advanced configuration options. The module ensures compliance with specified policies and implements the Terraform code to provision NAT gateway with ease, making it an ideal solution for those who want to streamline Nmbrs network infrastructure.

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
| [azurerm_nat_gateway.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_public_ip.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet_nat_gateway_association.natgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company / organization. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | Settings related to the network connectivity of the NAT gateway. | <pre>object({<br/>    vnet_name                = string<br/>    vnet_resource_group_name = string<br/>    subnets                  = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the resource group where the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_sequence_number"></a> [sequence\_number](#input\_sequence\_number) | A numeric value used to ensure uniqueness for resource names. | `number` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | Short, descriptive name for the application, service, or workload. Used in resource naming conventions. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The NAT gateway ID. |
| <a name="output_name"></a> [name](#output\_name) | The NAT gateway full name. |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The public IP address of the NAT gateway. |
| <a name="output_workload"></a> [workload](#output\_workload) | The NAT gateway workload name. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## NAT Gateway

### Basic Usage

```hcl
module "nat_gateway" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/nat_gateway"
  workload            = "myapp"
  company_prefix      = "nmbrs"
  environment         = "dev"
  location            = "westeurope"
  sequence_number     = 1
  resource_group_name = "rg-network-dev"

  network_settings = {
    vnet_name                = "vnet-myapp-dev-westeurope-001"
    vnet_resource_group_name = "rg-network-dev"
    subnets                  = ["subnet-private", "subnet-internal"]
  }
}
```

### With Name Override

```hcl
module "nat_gateway" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/nat_gateway"
  override_name       = "ng-custom-name"
  workload            = "myapp"
  environment         = "dev"
  location            = "westeurope"
  sequence_number     = 1
  resource_group_name = "rg-network-dev"

  network_settings = {
    vnet_name                = "vnet-myapp-dev-westeurope-001"
    vnet_resource_group_name = "rg-network-dev"
    subnets                  = ["subnet-private"]
  }
}
```
<!-- END_TF_DOCS -->
