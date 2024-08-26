# SSL Certificate module

## Summary

The `ssl_certificate` module provisions an SSL certificate in Azure for a specified domain name and resource group. It is designed to be stored in key vaults so it can be used by any application type.

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
| [azurerm_app_service_certificate_order.certificates](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_order) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for the SSL certificate. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

## Certificate for a single domain

```hcl
module "ssl_certificate" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/ssl_certificate"
  domain_name         = "domain.com"
  resource_group_name = "rg-demo"
}
```
