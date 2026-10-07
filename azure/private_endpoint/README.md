# Private Endpoint Module

## Summary

The `private_endpoint` module is a Terraform abstraction that implements the Terraform code needed to provision a single Azure Private Endpoint connecting a target resource to a private DNS zone, allowing private traffic to reach the service.

The module is policy-neutral — it accepts the target resource's ID and the subnet ID directly, without doing any internal data-source lookups. Callers wrap the module once per (target resource, subresource) pair.

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

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_private_endpoint.endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | Defines the private dns zone resource ID. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_resource_settings"></a> [resource\_settings](#input\_resource\_settings) | Defines the settings for the resource the private endpoint will connect to.<br/><br/>- `name`: the workload identifier, used to compose the PEP name (`pep-<name>-<subresource_name>`).<br/>- `resource_id`: the full Azure resource ID of the target (e.g. the `.id` output of the resource's module).<br/>- `subresource_name`: the Azure private-link subresource (e.g. `blob`, `vault`, `sites`, `SQL`). For the full list of valid values per resource type, see:<br/>  https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource | <pre>object(<br/>    {<br/>      name             = string<br/>      resource_id      = string<br/>      subresource_name = string<br/>    }<br/>  )</pre> | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The full Azure resource ID of the subnet where the private endpoint NIC will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The private endpoint ID. |
| <a name="output_name"></a> [name](#output\_name) | The private endpoint name. |
| <a name="output_network_interface_id"></a> [network\_interface\_id](#output\_network\_interface\_id) | The ID of the network interface associated with the private endpoint. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The private IP address associated with the private endpoint. |
<!-- END_TF_DOCS -->

## How to use it?

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

  subnet_id           = "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/rg-networks/providers/Microsoft.Network/virtualNetworks/vnet-mynetwork/subnets/snet-mysnet-002"
  private_dns_zone_id = "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/my-rg/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"
}
```
