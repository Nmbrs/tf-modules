<!-- BEGIN_TF_DOCS -->
## Summary

The Logs Analytics Workspace Terraform module simplifies the creation and management of Azure Log Analytics Workspaces, which serve as dedicated environments for log data aggregation from Azure Monitor, Microsoft Sentinel, Microsoft Defender for Cloud, and more. Each workspace operates with its distinct data repository and configuration while seamlessly consolidating data from various Azure services. This module offers a comprehensive solution for setting up and configuring Log Analytics workspaces, facilitating efficient log data analysis and insights generation.

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
| [azurerm_log_analytics_workspace.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company / organization. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this Log Analytics Workspace. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the resource group where the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The workspace data retention in days. | `number` | `90` | no |
| <a name="input_sequence_number"></a> [sequence\_number](#input\_sequence\_number) | A numeric value used to ensure uniqueness for resource names. | `number` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | Short, descriptive name for the application, service, or workload. Used in resource naming conventions. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Log Analytics Workspace ID. |
| <a name="output_name"></a> [name](#output\_name) | The log analytics workspace name. |
| <a name="output_primary_shared_key"></a> [primary\_shared\_key](#output\_primary\_shared\_key) | The Primary shared key for the Log Analytics Workspace. |
| <a name="output_secondary_shared_key"></a> [secondary\_shared\_key](#output\_secondary\_shared\_key) | The Secondary shared key for the Log Analytics Workspace. |
| <a name="output_workload"></a> [workload](#output\_workload) | The log analytics workspace workload name. |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The Workspace (or Customer) ID for the Log Analytics Workspace. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## Logs analytics workspace with public access enabled

```hcl
module "log_analytics_workspace" {
  source                        = "git::github.com/Nmbrs/tf-modules//azure/logs_analytics_workspace"
  
  workload                      = "myworkspace"
  resource_group_name           = "rg-my-resource-group"
  environment                   = "dev"
  location                      = "westeurope"
  retention_in_days             = 90
  
  public_network_access_enabled =  true
}
```

## Logs analytics workspace with public access disabled
```hcl
module "log_analytics_workspace" {
  source                        = "git::github.com/Nmbrs/tf-modules//azure/logs_analytics_workspace"
  
  workload                      = "myworkspace"
  resource_group_name           = "rg-my-resource-group"
  environment                   = "dev"
  location                      = "westeurope"
  retention_in_days             = 90
  
  public_network_access_enabled =  false
}
```
<!-- END_TF_DOCS -->
