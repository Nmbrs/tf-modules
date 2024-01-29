# Private DNS Zone Module

## Sumary

The `private_dns_zone` module is a Terraform abstraction that that implements all the necessary
Terraform code to create and manage private DNS zones in Azure, providing a reliable and secure DNS service for virtual networks. By using a custom domain name, the module can tailor the virtual network architecture to meet your Visma Nmbrs's specific needs.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.70 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.75.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the DNS Zone. Must be a valid domain name. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_vnet_links"></a> [vnet\_links](#input\_vnet\_links) | List of objects that represent the configuration of each virtual network link. | <pre>list(object({<br>    vnet_name            = string<br>    vnet_resource_group  = string<br>    registration_enabled = bool<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The DNS Zone ID. |
| <a name="output_max_number_of_record_sets"></a> [max\_number\_of\_record\_sets](#output\_max\_number\_of\_record\_sets) | Maximum number of Records in the zone. |
| <a name="output_max_number_of_virtual_network_links"></a> [max\_number\_of\_virtual\_network\_links](#output\_max\_number\_of\_virtual\_network\_links) | The maximum number of virtual networks that can be linked to this Private DNS zone. |
| <a name="output_max_number_of_virtual_network_links_with_registration"></a> [max\_number\_of\_virtual\_network\_links\_with\_registration](#output\_max\_number\_of\_virtual\_network\_links\_with\_registration) | The maximum number of virtual networks that can be linked to this Private DNS zone with registration enabled. |
| <a name="output_name"></a> [name](#output\_name) | The DNS Zone name. |
| <a name="output_number_of_record_sets"></a> [number\_of\_record\_sets](#output\_number\_of\_record\_sets) | The number of records already in the zone. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "private_dns_zone" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/private_dns_zone"
  name                = "contoso.com.dev"
  resource_group_name = "rg-demo"
    vnet_links = [
    {
      vnet_name            = "my-linked-vnet"
      vnet_resource_group  = "rg-vnet-dev"
      registration_enabled = true
    }
  ]
}
```

## DNS Zone naming rules:

The following rules should be applied when defining a name for the DNS Zone:

- The DNS zone name must contain no more than 253 characters.
- The DNS zone name must have between 2 and 34 labels.For example, 'contoso.com' has 2 labels.
- Each label must not exceed 63 characters.
- Each label must consist of letters, numbers, or hyphens, and must not start or end with a hyphen."
- The TLD (rightmost label of a domain name) Each label must consist of letters, numbers, or hyphens, and must not start or end with a hyphen. It must be at least 2 characters long and no more than 6 characters long".

### Valid Examples

- subomain1.sudomain2.com
- example.com

### Invalid Examples

- contoso.com. -> No trailing dot
- a -> It must have at least 2 labels
- subdomain.a -> The TLD must have at least 2 characters
- contoso.com -> It's not allowed to start or end a label with hyphens
