# Event Hub

## Sumary

The `event_hub` module is a Terraform abstraction that that implements all the necessary
Terraform code to create and manage event_hubs in Azure, that allows to stream data from any source.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.116 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub.event_hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_authorization_rule.eventhub_authorization_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_authorization_rule) | resource |
| [azurerm_eventhub_consumer_group.consumer_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group) | resource |
| [azurerm_eventhub_namespace.event_hub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_inflate_enabled"></a> [auto\_inflate\_enabled](#input\_auto\_inflate\_enabled) | The auto inflate enabled of the event hub namespace. | `bool` | n/a | yes |
| <a name="input_capacity"></a> [capacity](#input\_capacity) | The capacity of the event hub namespace. | `number` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_event_hubs_settings"></a> [event\_hubs\_settings](#input\_event\_hubs\_settings) | Configuration settings for the Event Hubs, including names, consumer groups, and authorization rules. | <pre>list(object({<br>    name = string<br>    consumer_groups = list(object({<br>      name              = string<br>      partition_count   = number<br>      message_retention = number<br>    }))<br>    authorization_rules = list(object({<br>      name   = string<br>      listen = bool<br>      send   = bool<br>      manage = bool<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_maximum_throughput_units"></a> [maximum\_throughput\_units](#input\_maximum\_throughput\_units) | The maximum throughput units of the event hub namespace. | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the Resource Group where the resource should exist. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The sku of the event hub namespace. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the event grid domain. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "event_hub" {
  source   = "git::github.com/Nmbrs/tf-modules//azure/event_hub"
  workload                 = "event_hub_name"
  environment              = "dev"
  location                 = "westeurope"
  resource_group_name      = "rg-myrg"
  capacity                 = "1"
  auto_inflate_enabled     = true
  maximum_throughput_units = 2
  sku                      = "Standard"
  event_hubs_settings = [
    {
      name = "hub-name1"
      consumer_groups = [
        {
          name = "consumer-group1"
          partition_count = 4
          message_retention = 7
        }
      ]
      authorization_rules = [
        {
          name = "auth-rule-name"
          listen = true
          send = false
          manage = false
        }
      ]
    },
    {
      name = "hub-name2"
      consumer_groups = [
        {
          name = "consumer-group2"
          partition_count = 4
          message_retention = 7
        }
      ]
      authorization_rules = [
        {
          name = "auth-rule-name2"
          listen = true
          send = false
          manage = false
        }
      ]
    }
  ]
}
```
