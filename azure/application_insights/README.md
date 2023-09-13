# Application Insights module

## Summary

The `application_insights` module enables users to easily provision and configure Azure Application Insights resources for monitoring and gaining insights into their applications. It simplifies the process of setting up Application Insights, allowing you to define key parameters such as resource name, location, all while maintaining infrastructure as code.

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
| [azurerm_application_insights.insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_log_analytics_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_type"></a> [application\_type](#input\_application\_type) | Specifies the retention period in days. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The workload name of the app insights component. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Specifies the retention period in days. | `number` | `90` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Configuration of the size and capacity of the logspace analytics. | `string` | n/a | yes |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | Name of the log analytics workspace that will be added to the NAT gateway | `string` | n/a | yes |
| <a name="input_workspace_resource_group_name"></a> [workspace\_resource\_group\_name](#input\_workspace\_resource\_group\_name) | Resource group of the log analytics workspace that will be added to the NAT gateway | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | The App ID associated with this Application Insights component. |
| <a name="output_connection_string"></a> [connection\_string](#output\_connection\_string) | The Connection String for this Application Insights component. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Application Insights component. |
| <a name="output_instrumentation_key"></a> [instrumentation\_key](#output\_instrumentation\_key) | The Instrumentation Key for this Application Insights component. |
| <a name="output_name"></a> [name](#output\_name) | The Application Insight component name. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## Virtual Gateway

```hcl
  module "app_insights" {
  source                        = "./azure/application_insights"
  workspace_name                = "rg-myworkspace-dev"
  workspace_resource_group_name = "myworkspace"
  name                          = "myapp-n1-nl"
  application_type              = "web"
  resource_group_name           = "rg-myapp-dev"
  environment                   = "dev"
  location                      = "westeurope"
  sku_name                      = "PerGB2018"
  retention_in_days             = 90
}
```
