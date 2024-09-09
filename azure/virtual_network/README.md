# Virtual Network Module

## Sumary

The `virtual_network` module supports the creation of Microsoft Azure virtual network in an existent Azure resource group name. This module also supports
the creation of vnet subnets and enables the vnet service delegation, when needed.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.116 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.116 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_spaces"></a> [address\_spaces](#input\_address\_spaces) | The address space that is used the virtual network. | `list(string)` | `[]` | no |
| <a name="input_ddos_plan_resource_id"></a> [ddos\_plan\_resource\_id](#input\_ddos\_plan\_resource\_id) | DDoS protection plan settings | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_naming_count"></a> [naming\_count](#input\_naming\_count) | A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance within the naming convention. | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of objects that represent the configuration of each subnet. | <pre>list(object({<br>    name                                          = string<br>    address_prefixes                              = list(string)<br>    delegations                                   = list(string)<br>    private_link_service_network_policies_enabled = bool<br>    private_endpoint_network_policies_enabled     = bool<br>    service_endpoints                             = list(string)<br><br>  }))</pre> | `[]` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the virtual network. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The virtual network ID. |
| <a name="output_name"></a> [name](#output\_name) | The virtual network full name. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Contains a list of the the resource id of the subnets |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Contains a list of the subnets data |
| <a name="output_workload"></a> [workload](#output\_workload) | The virtual network workload name. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "virtual_network" {
  source                = "git::github.com/Nmbrs/tf-modules//azure/virtual_network"
  resource_group_name   = "rg-demo-dev"
  workload              = "shared"
  naming_count          = 100
  address_spaces        = ["10.150.0.0/16"]
  environment           = "dev"
  location              = "westeurope"
  ddos_plan_resource_id = "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/rg-networks-prod/providers/Microsoft.Network/ddosProtectionPlans/my-plan"
  subnets = [
    {
      name                                          = "snet-dev-westeu-1000"
      address_prefixes                              = ["10.150.100.0/24"]
      delegations                                   = ["Microsoft.Web/serverFarms"]
      private_link_service_network_policies_enabled = false
      private_endpoint_network_policies_enabled     = false
      service_endpoints                             = ["Microsoft.EventHub", "Microsoft.Web", "Microsoft.Sql"]
    }
  ]
}
```
