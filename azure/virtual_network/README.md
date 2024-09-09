# Virtual Network Module

## Sumary

The `virtual_network` module supports the creation of Microsoft Azure virtual network in an existent Azure resource group name. This module also supports
the creation of vnet subnets and enables the vnet service delegation, when needed.

## Requirements

| Name                                                                     | Version           |
| ------------------------------------------------------------------------ | ----------------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | ~> 3.116          |

## Providers

| Name                                                         | Version  |
| ------------------------------------------------------------ | -------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | ~> 3.116 |

## Modules

No modules.

## Resources

| Name                                                                                                                            | Type     |
| ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                 | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name                                                                                       | Description                                                                                                                                                  | Type                                                                                                                                                                                                                                                                         | Default | Required |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_address_spaces"></a> [address_spaces](#input_address_spaces)                | The address space that is used the virtual network.                                                                                                          | `list(string)`                                                                                                                                                                                                                                                               | `[]`    |    no    |
| <a name="input_ddos_plan_settings"></a> [ddos_plan_settings](#input_ddos_plan_settings)    | DDoS protection plan settings                                                                                                                                | <pre>object({<br> resource_id = string<br> enabled = bool<br> })</pre>                                                                                                                                                                                                       | n/a     |   yes    |
| <a name="input_environment"></a> [environment](#input_environment)                         | The environment in which the resource should be provisioned.                                                                                                 | `string`                                                                                                                                                                                                                                                                     | n/a     |   yes    |
| <a name="input_location"></a> [location](#input_location)                                  | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string`                                                                                                                                                                                                                                                                     | n/a     |   yes    |
| <a name="input_naming_count"></a> [naming_count](#input_naming_count)                      | A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance within the naming convention.              | `number`                                                                                                                                                                                                                                                                     | n/a     |   yes    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | The name of the resource group in which to create the virtual network.                                                                                       | `string`                                                                                                                                                                                                                                                                     | n/a     |   yes    |
| <a name="input_subnets"></a> [subnets](#input_subnets)                                     | List of objects that represent the configuration of each subnet.                                                                                             | <pre>list(object({<br> name = string<br> address_prefixes = list(string)<br> delegations = list(string)<br> private_link_service_network_policies_enabled = bool<br> private_endpoint_network_policies_enabled = bool<br> service_endpoints = list(string)<br><br> }))</pre> | `[]`    |    no    |
| <a name="input_workload"></a> [workload](#input_workload)                                  | The workload name of the virtual network.                                                                                                                    | `string`                                                                                                                                                                                                                                                                     | n/a     |   yes    |

## Outputs

| Name                                                              | Description                                           |
| ----------------------------------------------------------------- | ----------------------------------------------------- |
| <a name="output_id"></a> [id](#output_id)                         | The virtual network ID.                               |
| <a name="output_name"></a> [name](#output_name)                   | The virtual network full name.                        |
| <a name="output_subnet_ids"></a> [subnet_ids](#output_subnet_ids) | Contains a list of the the resource id of the subnets |
| <a name="output_subnets"></a> [subnets](#output_subnets)          | Contains a list of the subnets data                   |
| <a name="output_workload"></a> [workload](#output_workload)       | The virtual network workload name.                    |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "virtual_network" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/virtual_network"
  resource_group_name = "rg-demo-dev"
  workload            = "shared"
  naming_count        = 100
  address_spaces      = ["10.150.0.0/16"]
  environment         = "dev"
  location            = "westeurope"
  ddos_plan_settings = {
    resource_id = "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/rg-networks-prod/providers/Microsoft.Network/ddosProtectionPlans/my-plan"
    enabled     = true
  }
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
