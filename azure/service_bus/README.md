# Service Bus Module

## Summary

The Service Bus module is a Terraform module that provides a convenient way to create a service bus and includes all necessary configurations to provision and manage it. The module ensures compliance with specified policies and implements the Terraform code to provision service buses with ease, making it an ideal solution for those who want to streamline Nmbrs infrastructure.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | git::github.com/Nmbrs/tf-modules//azure/private_endpoint | 49dc7f61a161fb90b42471ba30c15157384b6035 |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_servicebus_namespace.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The number of message units (resource isolation at the CPU and memory level so that each customer workload runs in isolation). | `number` | `0` | no |
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_firewall_settings"></a> [firewall\_settings](#input\_firewall\_settings) | Firewall configuration: public access, trusted-service bypass, and allowed subnets for VNet rules. All fields are optional and default to a secure-by-default posture (no public access, no allowed subnets, trusted-service bypass enabled). | <pre>object({<br/>    public_network_access_enabled            = optional(bool, false)<br/>    trusted_services_bypass_firewall_enabled = optional(bool, true)<br/>    allowed_subnet_ids                       = optional(list(string), [])<br/>  })</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Override the name of the service bus namespace, to bypass naming convention. | `string` | `null` | no |
| <a name="input_premium_messaging_partitions"></a> [premium\_messaging\_partitions](#input\_premium\_messaging\_partitions) | Number of messaging partitions for a Premium namespace. Only honored when `sku_name = "Premium"` — must be 0 for Basic/Standard. Valid values: 0, 1, 2, 4. Changing this forces resource recreation. | `number` | `0` | no |
| <a name="input_private_endpoint_settings"></a> [private\_endpoint\_settings](#input\_private\_endpoint\_settings) | Settings for the private endpoint provisioned by this module. `subnet_id` is the resource ID of the subnet where the PEP NIC lands. `private_dns_zone_ids` maps each required subresource to its private DNS zone resource ID. | <pre>object({<br/>    subnet_id = string<br/>    private_dns_zone_ids = object({<br/>      namespace = string<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Configuration of the size and capacity of the service bus. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the service bus namespace. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_default_connection_string"></a> [default\_connection\_string](#output\_default\_connection\_string) | The primary connection string for the authorization rule RootManageSharedAccessKey which is created automatically by Azure. |
| <a name="output_id"></a> [id](#output\_id) | The servicebus namespace ID. |
| <a name="output_name"></a> [name](#output\_name) | The servicebus namespace name. |
| <a name="output_workload"></a> [workload](#output\_workload) | The servicebus namespace workload name. |
<!-- END_TF_DOCS -->

## How to use it?

Private endpoint support for Azure Service Bus is gated by the **Premium** tier — Basic and Standard tiers cannot have private endpoints. The module reflects this with `private_endpoint_settings`: it is **required for Premium**, and must be **null (omitted) for Basic/Standard**. Plan-time preconditions enforce both directions.

The `firewall_settings` variable is optional and defaults to a secure-by-default posture (no public network access, no allowed subnets, trusted-service bypass enabled) — omit it entirely to use the defaults, or override specific fields as shown in the Premium-with-VNet-rules example. The examples below assume the relevant subnet and the `privatelink.servicebus.windows.net` DNS zone already exist.

### Service Bus - Basic Tier (no private endpoint)

```hcl
module "service_bus" {
  source = "git::github.com/Nmbrs/tf-modules//azure/service_bus"

  workload            = "test"
  company_prefix      = "nmbrs"
  environment         = "dev"
  location            = "westeurope"
  resource_group_name = "rg-service-bus"
  sku_name            = "Basic"
  capacity            = 0

  # private_endpoint_settings is omitted — Basic/Standard tiers do not support private endpoints
}
```

### Service Bus - Premium Tier

```hcl
module "service_bus" {
  source = "git::github.com/Nmbrs/tf-modules//azure/service_bus"

  workload                     = "app1"
  company_prefix               = "nmbrs"
  environment                  = "dev"
  location                     = "westeurope"
  resource_group_name          = "rg-service-bus"
  sku_name                     = "Premium"
  capacity                     = 1
  premium_messaging_partitions = 1

  private_endpoint_settings = {
    subnet_id = "/subscriptions/.../subnets/snet-private-endpoints"
    private_dns_zone_ids = {
      namespace = module.dns_zone_servicebus.id
    }
  }
}
```

### Service Bus - Premium with public access and VNet rules

Use this variant when the Premium namespace must remain reachable from public networks alongside the private endpoint and you want to restrict that public path to specific VNet subnets. `firewall_settings.allowed_subnet_ids` creates VNet rules; it is only honoured when `sku_name = "Premium"` and `public_network_access_enabled = true`.

```hcl
module "service_bus" {
  source = "git::github.com/Nmbrs/tf-modules//azure/service_bus"

  workload                     = "app1"
  company_prefix               = "nmbrs"
  environment                  = "prod"
  location                     = "westeurope"
  resource_group_name          = "rg-service-bus"
  sku_name                     = "Premium"
  capacity                     = 1
  premium_messaging_partitions = 1

  firewall_settings = {
    public_network_access_enabled = true
    allowed_subnet_ids = [
      "/subscriptions/.../subnets/snet-app-001",
    ]
  }

  private_endpoint_settings = {
    subnet_id = "/subscriptions/.../subnets/snet-private-endpoints"
    private_dns_zone_ids = {
      namespace = module.dns_zone_servicebus.id
    }
  }
}
```

### Service Bus with a custom name override

```hcl
module "service_bus" {
  source = "git::github.com/Nmbrs/tf-modules//azure/service_bus"

  override_name                = "sb-my-custom-name"
  environment                  = "dev"
  location                     = "westeurope"
  resource_group_name          = "rg-service-bus"
  sku_name                     = "Premium"
  capacity                     = 1
  premium_messaging_partitions = 1

  private_endpoint_settings = {
    subnet_id = "/subscriptions/.../subnets/snet-private-endpoints"
    private_dns_zone_ids = {
      namespace = module.dns_zone_servicebus.id
    }
  }
}
```
