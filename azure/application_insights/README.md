# Application Insights module

## Summary

The `application_insights` module enables users to easily provision and configure Azure Application Insights resources for monitoring and gaining insights into their applications. It simplifies the process of setting up Application Insights, allowing you to define key parameters such as resource name, location, all while maintaining infrastructure as code.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_log_analytics_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_type"></a> [application\_type](#input\_application\_type) | Specifies the type of Application Insights to create. Valid options are 'ios', 'java', 'MobileCenter', 'Node.JS', 'other', 'phone', 'store', 'web'. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Override the name of the Application Insights component. If not provided, the name will be generated based on the naming convention. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Specifies the retention period in days. Valid values are 30, 60, 90, 120, 180, 270, 365, 550, 730. | `number` | `90` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the Application Insights component. | `string` | `null` | no |
| <a name="input_workspace_settings"></a> [workspace\_settings](#input\_workspace\_settings) | Settings for the Log Analytics Workspace to associate with Application Insights. | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | The App ID associated with this Application Insights component. |
| <a name="output_connection_string"></a> [connection\_string](#output\_connection\_string) | The Connection String for this Application Insights component. |
| <a name="output_id"></a> [id](#output\_id) | The ARM resource ID of the Application Insights component. |
| <a name="output_instrumentation_key"></a> [instrumentation\_key](#output\_instrumentation\_key) | The Instrumentation Key for this Application Insights component. |
| <a name="output_name"></a> [name](#output\_name) | The Application Insights component name. |
| <a name="output_workload"></a> [workload](#output\_workload) | The Application Insights workload name. |
<!-- END_TF_DOCS -->

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Application Insights with default retention (web app)

```hcl
module "app_insights" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/application_insights"
  workload            = "myapp"
  application_type    = "web"
  resource_group_name = "rg-myapp-dev"
  environment         = "dev"
  location            = "westeurope"
  workspace_settings = {
    name                = "log-myapp-dev"
    resource_group_name = "rg-myapp-dev"
  }
}
```

### Application Insights with extended retention for production

```hcl
module "app_insights" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/application_insights"
  workload            = "myapp"
  application_type    = "web"
  resource_group_name = "rg-myapp-prod"
  environment         = "prod"
  location            = "westeurope"
  retention_in_days   = 365
  workspace_settings = {
    name                = "log-myapp-prod"
    resource_group_name = "rg-myapp-prod"
  }
}
```

### Application Insights with a custom name override

```hcl
module "app_insights" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/application_insights"
  override_name       = "my-custom-appi-name"
  application_type    = "web"
  resource_group_name = "rg-myapp-prod"
  environment         = "prod"
  location            = "westeurope"
  workspace_settings = {
    name                = "log-myapp-prod"
    resource_group_name = "rg-myapp-prod"
  }
}
```
