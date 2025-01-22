<!-- BEGIN_TF_DOCS -->
# Service Bus Module

## Summary

The Service Bus module is a Terraform module that provides a convenient way to create a service bus and includes all necessary configurations to provision and manage it. The module ensures compliance with specified policies and implements the Terraform code to provision service buses with ease, making it an ideal solution for those who want to streamline Nmbrs infrastructure.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.117 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_servicebus_namespace.service_bus](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The number of message units (resource isolation at the CPU and memory level so that each customer workload runs in isolation). | `number` | `0` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Configuration of the size and capacity of the service bus. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the service bus namespace. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_connection_string"></a> [default\_connection\_string](#output\_default\_connection\_string) | The primary connection string for the authorization rule RootManageSharedAccessKey which is created automatically by Azure. |
| <a name="output_id"></a> [id](#output\_id) | The servicebus namespace ID. |
| <a name="output_name"></a> [name](#output\_name) | The servicebus namespace name. |
| <a name="output_workload"></a> [workload](#output\_workload) | The servicebus namespace workload name. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Service Bus - Basic Tier

```hcl
module "service_bus" {
  source = "git::github.com/Nmbrs/tf-modules//azure/service_bus"

  workload            = "test"
  environment         = "dev"
  location            = "westeurope"
  resource_group_name = "rg-service-bus"
  sku_name            = "Basic"
  capacity            = 0
}
```

### Service Bus - Premium Tier (Zone Redundancy Disabled)

```hcl
module "service_bus" {
  source = "git::github.com/Nmbrs/tf-modules//azure/service_bus"

  workload            = "app1"
  environment         = "dev"
  location            = "westeurope"
  resource_group_name = "rg-service-bus"
  sku_name            = "Premium"
  capacity            = 1
}
```
<!-- END_TF_DOCS -->
