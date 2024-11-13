<!-- BEGIN_TF_DOCS -->
# Event Hub Module

## Summary

The `event_hub` module is a Terraform abstraction that simplifies the management of Event Hub in Azure. It provides the necessary Terraform code to create and configure Event Hub, enabling data-streaming for millions of events per second within your Visma Nmbrs infrastructure. With this module, you can tailor event-hub to suit specific application requirements.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.116 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |

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
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | `"dev"` | no |
| <a name="input_event_hub"></a> [event\_hub](#input\_event\_hub) | The names of the event hubs | `list(string)` | <pre>[<br>  "insights-activity-logs",<br>  "insights-appgtw-logs",<br>  "insights-defender-alerts",<br>  "insights-signin-logs"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | `"westeurope"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the Resource Group where the resource should exist. | `string` | `"rg-pedroluis"` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the event grid domain. | `string` | `"slm"` | no |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "event_hub" {
  source                        = "git::github.com/Nmbrs/tf-modules//azure/event_hub"
  workload                      = "my-event-grid-hub-namespace"
  resource_group_name           = "rg-my-resource-group"
  environment                   = "dev"
  location                      = "westeurope"
  event_hub                     = "my-event-hub-name"
  capacity                      = 1
  auto_inflate_enabled          = true
  maximum_throughput_units      = 2
}
```
<!-- END_TF_DOCS -->
