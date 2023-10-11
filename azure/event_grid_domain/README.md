# Event Grid Domain Module

## Summary

The `event_grid_domain` module is a Terraform abstraction that simplifies the management of Event Grid domains in Azure. It provides the necessary Terraform code to create and configure Event Grid domains, enabling efficient event routing and messaging within your Visma Nmbrs infrastructure. With this module, you can tailor event-driven topics to suit specific application requirements, ensuring seamless event processing and integration.

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
| [azurerm_eventgrid_domain.domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain) | resource |
| [azurerm_eventgrid_domain_topic.topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance in the naming convention. | `number` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name which should be used for this Private DNS Resolver. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this resource | `bool` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the Resource Group where the Private DNS Resolver should exist. | `string` | n/a | yes |
| <a name="input_topics"></a> [topics](#input\_topics) | List of event grid domain topics. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint associated with the event grid domain. |
| <a name="output_id"></a> [id](#output\_id) | The event grid domain ID. |
| <a name="output_name"></a> [name](#output\_name) | The event grid domain name. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key associated with the event grid domain. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The second access key associated with the event grid domain. |
| <a name="output_topics"></a> [topics](#output\_topics) | The details of the inbound endpoints. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "event_grid_domain" {
  source                        = "git::github.com/Nmbrs/tf-modules//azure/event_grid_domain"
  name                          = "my-event-grid-domain"
  resource_group_name           = "rg-my-resource-group"
  environment                   = "dev"
  location                      = "westeurope"
  public_network_access_enabled = false
  topics                        = ["a", "b", "c", "d"]
}
```