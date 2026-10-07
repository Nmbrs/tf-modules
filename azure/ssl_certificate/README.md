<!-- BEGIN_TF_DOCS -->
# SSL Certificate module

## Summary

The `ssl_certificate` module provisions an SSL certificate in Azure for a specified domain name and resource group. It is designed to be stored in key vaults so it can be used by any application type.

## Certificate validity

The module does **not** expose or set `validity_in_years` on the underlying `azurerm_app_service_certificate_order`, and it explicitly ignores that attribute in the resource lifecycle. This is intentional, for the reasons below.

1. **The Azure ARM contract only accepts `1`.** The official ARM reference for `Microsoft.CertificateRegistration/certificateOrders` documents `validityInYears` as *"Duration in years (must be 1)"* ([ARM reference](https://learn.microsoft.com/en-us/azure/templates/microsoft.certificateregistration/certificateorders)). The Terraform `azurerm` provider advertises a range of 1–3, but Azure rejects anything other than 1 in practice.

2. **The actual certificate lifetime is set by the CA, not by this field.** App Service Certificates are issued by GoDaddy and are bound by the [CA/Browser Forum Baseline Requirements](https://cabforum.org/working-groups/server/baseline-requirements/documents/). Ballot **[SC-081v3](https://cabforum.org/2025/04/11/ballot-sc-081v3-introduce-schedule-of-reducing-validity-and-data-reuse-periods/)** (adopted April 2025) imposes the following maximum TLS certificate lifetimes:

   | Effective date | Max validity |
   |---|---|
   | until 2026-03-15 | 398 days |
   | 2026-03-15 → 2027-03-15 | **200 days** |
   | 2027-03-15 → 2029-03-15 | 100 days |
   | from 2029-03-15 | 47 days |

   Newly issued certificates therefore have lifetimes shorter than one year regardless of what is requested in Terraform. Auto-renew (`auto_renew = true`) keeps the certificate continuously valid by re-issuing within the renewal window.

3. **Setting the field produces perpetual drift.** Once the certificate order is issued, the ARM API returns `validityInYears = 0` on subsequent reads. With the field set in Terraform, every plan reports a change from the configured value back to `0`. Ignoring the attribute in `lifecycle.ignore_changes` is the supported way to suppress this drift.

Because the field is optional in the provider, has a sensible default (`1`, the only legal ARM value), is overridden by the CA, and causes drift if set, it is omitted from the module surface and ignored at the lifecycle level.

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
| [azurerm_app_service_certificate_order.certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_order) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the domain. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Override the name of the certificate, to bypass naming convention | `string` | `null` | no |
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
<!-- END_TF_DOCS -->