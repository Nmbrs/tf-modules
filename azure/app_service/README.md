# Appservice module

## Summary

The `app_service` module provides a comprehensive Terraform solution for setting up Azure Web App Services, offering seamless support for both Linux and Windows operating systems. This module streamlines the process of creating and configuring Azure Web App instances. It handles essential tasks such as provisioning the necessary infrastructure, defining deployment configurations, and establishing platform-specific settings. By abstracting these complexities, the module ensures consistent and efficient deployment of web apps, regardless of the underlying operating system.

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
| [azurerm_app_service_virtual_network_swift_connection.web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_service_plan.service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_windows_web_app.web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app) | resource |
| [azurerm_subnet.service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_user_assigned_identity.managed_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_names"></a> [app\_service\_names](#input\_app\_service\_names) | List of desired applications to be deployed on app service plan resource (webapp, mobile, identity, others). | `list(string)` | n/a | yes |
| <a name="input_client_affinity_enabled"></a> [client\_affinity\_enabled](#input\_client\_affinity\_enabled) | Specifies if client affinity should be enabled or not. | `bool` | `false` | no |
| <a name="input_country"></a> [country](#input\_country) | Specifies the country for the app services and service plan names. | `string` | n/a | yes |
| <a name="input_dotnet_version"></a> [dotnet\_version](#input\_dotnet\_version) | defines the dotnet framework version for the all app services. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | defines the environment to provision the resources. | `string` | n/a | yes |
| <a name="input_load_balancing_mode"></a> [load\_balancing\_mode](#input\_load\_balancing\_mode) | The O/S type for the App Services to be hosted in this plan. Changing this forces a new AppService to be created. | `string` | `"LeastResponseTime"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_managed_identity_settings"></a> [managed\_identity\_settings](#input\_managed\_identity\_settings) | A list of settings related to the application service managed identity. | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | Defines the network settings for the resources, specifying the subnet, virtual network name, and the resource group for the virtual network. | <pre>object(<br>    {<br>      subnet_name              = string<br>      vnet_name                = string<br>      vnet_resource_group_name = string<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_node_number"></a> [node\_number](#input\_node\_number) | Specifies the node number for the resources. | `number` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The O/S type for the App Services to be hosted in this plan. Changing this forces a new AppService to be created. | `string` | `"Windows"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_service_plan_name"></a> [service\_plan\_name](#input\_service\_plan\_name) | The name which should be used for this Service Plan. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Defines the The SKU name for the plan. (i.e: S1, P1V2 etc). | `string` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | defines the stack for the webapp. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_services"></a> [app\_services](#output\_app\_services) | List of Azure Windows Web Apps with their respective names and IDs. |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | The ID of the Azure Service Plan. |
| <a name="output_service_plan_os_type"></a> [service\_plan\_os\_type](#output\_service\_plan\_os\_type) | The operating system type associated with the Azure Service Plan. |
| <a name="output_service_plan_sku_name"></a> [service\_plan\_sku\_name](#output\_service\_plan\_sku\_name) | The SKU name associated with the Azure Service Plan. |

## How to use it? 

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform. 

## App Service Plan With One WebApp 

```hcl 
module "app_service_plan" {
  source                  = "git::github.com/Nmbrs/tf-modules//azure/app_service"
  service_plan_name       = "myserviceplan"
  resource_group_name     = "rg-myapp"
  environment             = "dev"
  location                = "westeurope"
  sku                     = "P2v3"
  stack                   = "dotnet"
  dotnet_version          = "v4.0"
  client_affinity_enabled = true
  network_settings = {
    vnet_resource_group_name = "rg-myvnet"
    vnet_name                = "vnet-myvnet-dev-001"
    subnet_name              = "snet-appservices-001"
  }
  managed_identity_settings = {
    name                = "mi-myidentity"
    resource_group_name = "rg-myrg"
  }
  app_insights_settings = {
    name                = "appi-test-test"
    resource_group_name = "rg-test-test"
  }
  app_service_names = ["web"]
}
``` 
## App Service Plan With Multiple WebApps 

```hcl 
module "app_service_plan" {
  source                  = "git::github.com/Nmbrs/tf-modules//azure/app_service"
  service_plan_name       = "myserviceplan"
  resource_group_name     = "rg-myapp"
  environment             = "dev"
  location                = "westeurope"
  sku                     = "P2v3"
  stack                   = "dotnet"
  dotnet_version          = "v4.0"
  client_affinity_enabled = true
  network_settings = {
    vnet_resource_group_name = "rg-myvnet"
    vnet_name                = "vnet-myvnet-dev-001"
    subnet_name              = "snet-appservices-001"
  }
  managed_identity_settings = {
    name                = "mi-myidentity"
    resource_group_name = "rg-myrg"
  }
  app_insights_settings = {
    name                = "appi-test-test"
    resource_group_name = "rg-test-test"
  }
  app_service_names = ["web", "worker"]
}
```
