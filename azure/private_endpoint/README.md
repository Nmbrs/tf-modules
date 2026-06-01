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
| [azurerm_private_endpoint.endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_network_settings"></a> [network\_settings](#input\_network\_settings) | Defines the network settings for the resources, specifying the subnet, virtual network name, and the resource group for the virtual network. | <pre>object(<br/>    {<br/>      subnet_name              = string<br/>      vnet_name                = string<br/>      vnet_resource_group_name = string<br/>    }<br/>  )</pre> | n/a | yes |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | Defines the private dns zone resource ID. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_resource_settings"></a> [resource\_settings](#input\_resource\_settings) | Defines the settings for the resource the private endpoint will connect to.<br/><br/>- `name`: the workload identifier, used to compose the PEP name (`pep-<name>-<subresource_name>`).<br/>- `resource_id`: the full Azure resource ID of the target (e.g. the `.id` output of the resource's module).<br/>- `subresource_name`: the Azure private-link subresource (e.g. `blob`, `vault`, `sites`, `SQL`). For the full list of valid values per resource type, see:<br/>  https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource | <pre>object(<br/>    {<br/>      name             = string<br/>      resource_id      = string<br/>      subresource_name = string<br/>    }<br/>  )</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The private endpoint ID. |
| <a name="output_name"></a> [name](#output\_name) | The private endpoint name. |
| <a name="output_network_interface_id"></a> [network\_interface\_id](#output\_network\_interface\_id) | The ID of the network interface associated with the private endpoint. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The private IP address associated with the private endpoint. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "private_endpoint" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/private_endpoint"
  resource_group_name = "rg-myrg"
  location            = "westeurope"
  resource_settings = {
    name             = "as-web-test"
    resource_id      = "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/rg-resource-rg/providers/Microsoft.Web/sites/as-web-test"
    subresource_name = "sites"
  }
  network_settings = {
    vnet_name                = "vnet-mynetwork"
    subnet_name              = "snet-mysnet-002"
    vnet_resource_group_name = "rg-networks"
  }
  private_dns_zone_id = "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/my-rg/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"
}
```
<!-- END_TF_DOCS -->
