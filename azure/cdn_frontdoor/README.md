<!-- BEGIN_TF_DOCS -->
# CDN Frontdoor Module

## Sumary

The `cdn_frontdoor` module is an abstraction that implements all the necessary Terraform code to provision an Azure FrontDoor with success, and accordingly with Visma Nmbrs policies.

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
| [azurerm_cdn_frontdoor_custom_domain.domain](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_custom_domain) | resource |
| [azurerm_cdn_frontdoor_endpoint.endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_endpoint) | resource |
| [azurerm_cdn_frontdoor_origin.origin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_origin) | resource |
| [azurerm_cdn_frontdoor_origin_group.group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_origin_group) | resource |
| [azurerm_cdn_frontdoor_profile.profile](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_profile) | resource |
| [azurerm_cdn_frontdoor_route.route](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_route) | resource |
| [azurerm_cdn_frontdoor_rule.caching_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_rule) | resource |
| [azurerm_cdn_frontdoor_rule_set.rule_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_rule_set) | resource |
| [azurerm_dns_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/dns_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | A list of frontdoor endpoints. | <pre>list(object({<br/>    name                    = string<br/>    caching_rule_enabled    = optional(bool, false)<br/>    caching_timeout_minutes = optional(number, null)<br/>    custom_domains = list(object({<br/>      fqdn                         = string<br/>      dns_zone_name                = string<br/>      dns_zone_resource_group_name = string<br/>    }))<br/>    origin_settings = object({<br/>      fqdns                    = list(string)<br/>      path                     = string<br/>      patterns_to_match        = list(string)<br/>      session_affinity_enabled = bool<br/>    })<br/>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_response_timeout_seconds"></a> [response\_timeout\_seconds](#input\_response\_timeout\_seconds) | The timeout period, in seconds, for responses. This value must be between 10 and 20 seconds. | `number` | `60` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Configuration of the size and capacity of the logspace analytics. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The name of the workload associated with the resource. | `string` | n/a | yes |

## Outputs

No outputs.

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### CDN Front Door with cache enabled
```hcl
module "cnd_frontdoor" {
  source                   = "git::github.com/Nmbrs/tf-modules//azure/cnd_frontdoor"
  workload                 = "myfrontdoor"
  resource_group_name      = "rg-my-resource-group"
  environment              = "dev"
  sku_name                 = "Premium"
  response_timeout_seconds = 200
  endpoints = [
    {
      name = "myendpoint"
      custom_domains = [
        {
          fqdn                         = "cdn.mydomain.com"
          dns_zone_name                = "mydomain.com"
          dns_zone_resource_group_name = "rg-dnszones"
        },
        {
          fqdn : "cdn.otherdomain.com"
          dns_zone_name : "otherdomaain.com"
          dns_zone_resource_group_name = "rg-dnszones"
        }
      ]
      caching_rule_enabled    = true
      caching_timeout_minutes = 45
      origin_settings : {
        fqdns                    = ["storage.blob.core.windows.net"]
        path                     = "/"
        patterns_to_match        = ["/", "/*"],
        session_affinity_enabled = false
      }
    },
  ]
}
```

### CDN Front Door with no cache enabled
```hcl
module "cnd_frontdoor" {
  source                   = "git::github.com/Nmbrs/tf-modules//azure/cnd_frontdoor"
  workload                 = "myfrontdoor"
  resource_group_name      = "rg-my-resource-group"
  environment              = "dev"
  sku_name                 = "Premium"
  response_timeout_seconds = 200
  endpoints = [
    {
      name = "myendpoint"
      custom_domains = [
        {
          fqdn                         = "cdn.mydomain.com"
          dns_zone_name                = "mydomain.com"
          dns_zone_resource_group_name = "rg-dnszones"
        },
        {
          fqdn : "cdn.otherdomain.com"
          dns_zone_name : "otherdomaain.com"
          dns_zone_resource_group_name = "rg-dnszones"
        }
      ]
      caching_rule_enabled    = false
      caching_timeout_minutes = 0
      origin_settings : {
        fqdns                    = ["storage.blob.core.windows.net"]
        path                     = "/"
        patterns_to_match        = ["/", "/*"],
        session_affinity_enabled = false
      }
    },
  ]
}

```
<!-- END_TF_DOCS -->
