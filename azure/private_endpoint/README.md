# Private Endpoint

## Sumary

The `private_endpoint` module is a Terraform abstraction that that implements all the necessary
Terraform code to create and manage private endpoints in Azure, that connects you privately and securely to a private dns zone and allows private traffic to reach the service.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.105.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_container_registry.container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry) | data source |
| [azurerm_eventgrid_domain.eventgrid_domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventgrid_domain) | data source |
| [azurerm_eventgrid_topic.eventgrid_topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/eventgrid_topic) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_mssql_server.sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_server) | data source |
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_servicebus_namespace.service_bus](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/servicebus_namespace) | data source |
| [azurerm_storage_account.storage_account_blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.storage_account_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_account.storage_account_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_windows_web_app.app_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/windows_web_app) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance in the naming convention. | `number` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | Defines the network settings for the resources, specifying the subnet, virtual network name, and the resource group for the virtual network. | <pre>object(<br>    {<br>      subnet_name              = string<br>      vnet_name                = string<br>      vnet_resource_group_name = string<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_private_dns_zone_settings"></a> [private\_dns\_zone\_settings](#input\_private\_dns\_zone\_settings) | Defines the private dns zone settings. | <pre>object(<br>    {<br>      use_custom_dns_zone = bool<br>      custom_name         = optional(string)<br>      resource_group_name = string<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_resource_settings"></a> [resource\_settings](#input\_resource\_settings) | Defines the settings for the associated resources, specifying the name, and the resource group for it. | <pre>object(<br>    {<br>      name                = string<br>      type                = string<br>      resource_group_name = string<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the private endpoint. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "private_endpoint" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/private_endpoint"
  workload            = "as-web-test"
  resource_group_name = rg-myrg
  location            = "westeurope"
  environment         = "dev"
  instance_count      = 1
  resource_settings = {
    name                = "as-web-test"
    type                = "app_service"
    resource_group_name = "rg-resource-rg"
  }
  network_settings = {
    vnet_name                = "vnet-mynetwork"
    subnet_name              = "snet-mysnet-002"
    vnet_resource_group_name = "rg-networks"
  }
  private_dns_zone_settings = {
    use_custom_dns_zone = true
    custom_name         = "mydnszone.net"
    resource_group_name = "rg-dnszones"
  }
}
```