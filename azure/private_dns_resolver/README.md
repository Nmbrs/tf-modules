# Private DNS reolver

## Summary

The `private_dns_resolver` module simplifies the creation and management of private DNS resolvers within virtual networks. With this module, users can effortlessly configure and provision private DNS resolvers, enabling the resolution of private domain names within their Azure environments. By abstracting away complexities, the module offers a streamlined interface for defining desired resolver settings, such as virtual network associations, subnet configurations, and forwarding options.

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
| [azurerm_private_dns_resolver.resolver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver) | resource |
| [azurerm_private_dns_resolver_inbound_endpoint.inbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_inbound_endpoint) | resource |
| [azurerm_private_dns_resolver_outbound_endpoint.outbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_outbound_endpoint) | resource |
| [azurerm_subnet.inbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.outbound_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_inbound_endpoints"></a> [inbound\_endpoints](#input\_inbound\_endpoints) | List of objects that represent the configuration of each inbound endpoint. | `list(string)` | `[]` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance in the naming convention. | `number` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_outbound_endpoints"></a> [outbound\_endpoints](#input\_outbound\_endpoints) | List of objects that represent the configuration of each outbound endpoint. | `list(string)` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the Resource Group where the Private DNS Resolver should exist. | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Specifies the name of the VNET associated with the Private DNS Resolver. | `string` | n/a | yes |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | Specifies the name of the VNET name associated with the Private DNS Resolver. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | Specifies the name which should be used for this Private DNS Resolver. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The private DNS resolver ID. |
| <a name="output_inbound_endpoints"></a> [inbound\_endpoints](#output\_inbound\_endpoints) | The details of the inbound endpoints. |
| <a name="output_name"></a> [name](#output\_name) | The private DNS resolver full name. |
| <a name="output_outbound_endpoints"></a> [outbound\_endpoints](#output\_outbound\_endpoints) | The details of the outbound endpoints. |
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | The private DNS resolver virtual ntwork id. |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The private DNS resolver virtual network name. |
| <a name="output_workload"></a> [workload](#output\_workload) | The private DNS resolver workload name. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## Private DNS resolver with inbound endpoints

```hcl
module "private_dns_resolver" {
  source = "git::github.com/Nmbrs/tf-modules//azure/private_dns_resolver"

  workload                 = "my-resolver"
  instance_count           = 1
  resource_group_name      = "rg-private-resolver"
  location                 = "westeurope"
  environment              = "dev"
  vnet_name                = "my-vnet"
  vnet_resource_group_name = "rg-vnets"
  inbound_endpoints        = ["snet-inboundprivatedns-001", "snet-inboundprivatedns-002"]
}
```

## Private DNS resolver with outbound endpoints

```hcl
module "private_dns_resolver" {
  source = "git::github.com/Nmbrs/tf-modules//azure/private_dns_resolver"

  workload                 = "my-resolver"
  instance_count           = 2
  resource_group_name      = "rg-private-resolver"
  location                 = "westeurope"
  environment              = "dev"
  vnet_name                = "my-vnet"
  vnet_resource_group_name = "rg-vnets"
  outbound_endpoints       = ["snet-outboundprivatedns-001", "snet-outboundprivatedns-002"]
}
```

## Private DNS resolver with inbound and outbound endpoints
```hcl
module "private_dns_resolver" {
  source = "git::github.com/Nmbrs/tf-modules//azure/private_dns_resolver"

  workload                 = "my-resolver"
  instance_count           = 3
  resource_group_name      = "rg-private-resolver"
  location                 = "westeurope"
  environment              = "dev"
  vnet_name                = "my-vnet"
  vnet_resource_group_name = "rg-vnets"
  inbound_endpoints        = ["snet-inboundprivatedns-001", "snet-inboundprivatedns-002"]
  outbound_endpoints       = ["snet-outboundprivatedns-001", "snet-outboundprivatedns-002"]
}
```