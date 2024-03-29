# DNS Records Module

## Sumary

The dns_records module is a Terraform module that allows for the management of DNS A Records, C Records, and TXT Records within Azure DNS. It ensures compliance with Visma Nmbrs policies and implements the necessary Terraform code to provision DNS records in an existing DNS Zone.

> Keep in mind that due to a limitation of the Azure DNS API, which has a throttle limit of 500 read (GET) operations per 5 minutes, this module was designed to be used with a small list of records. In larger configurations, the operation may time out by default.

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
| [azurerm_dns_a_record.record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_cname_record.record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_txt_record.record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_a"></a> [a](#input\_a) | A record to be created | <pre>list(object({<br>    name    = string<br>    records = list(string)<br>    ttl     = number<br>  }))</pre> | `[]` | no |
| <a name="input_cname"></a> [cname](#input\_cname) | CNAME record to be created | <pre>list(object({<br>    name   = string<br>    record = string<br>    ttl    = number<br>  }))</pre> | `[]` | no |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | Name of the DNS zone | `string` | n/a | yes |
| <a name="input_dns_zone_rg"></a> [dns\_zone\_rg](#input\_dns\_zone\_rg) | Resource Group of the DNS Zone | `string` | n/a | yes |
| <a name="input_txt"></a> [txt](#input\_txt) | TXT record to be created | <pre>list(object({<br>    name    = string<br>    records = list(string)<br>    ttl     = number<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_a_fqdn"></a> [a\_fqdn](#output\_a\_fqdn) | The FQDN of the A record |
| <a name="output_cname_fqdn"></a> [cname\_fqdn](#output\_cname\_fqdn) | The FQDN of the CNAME record |
| <a name="output_txt_fqdn"></a> [txt\_fqdn](#output\_txt\_fqdn) | The FQDN of the TXT record |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

```hcl
module "dns_records" {
  source        = "git::github.com/Nmbrs/tf-modules//azure/dns_records"
  dns_zone_name = "contoso.com.dev"
  dns_zone_rg   = "rg-dns-zones"
  a = [
    {
      name    = "web"
      records = ["192.168.1.1"]
      ttl     = 300
    },
    {
      name    = "worker"
      records = ["192.168.1.2", "192.168.1.3"]
      ttl     = 300
    }
  ]

  cname = [
    {
      name   = "api"
      record = "api.azurewebsites.net"
      ttl    = 300
    }
  ]

  txt = [
    {
      name    = "_acme-challenge"
      records = ["__2asdnkaASAFc-Xx8ASFASGFmka-EwvGO5asdqwWfasfdR64No"]
      ttl     = 300
    }
  ]
}
```
