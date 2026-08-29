# Azure Container Registry Module

## Summary

This module creates an Azure Container Registry with flexible naming options and SKU-based configuration. The module enforces sensible defaults for security (admin user disabled; private-by-default on Premium) and validates SKU-aware constraints at plan time.

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

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | git::github.com/Nmbrs/tf-modules//azure/private_endpoint | f41a116c9f31892191b5e3f146a1e361bfc57322 |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_container_registry.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_firewall_settings"></a> [firewall\_settings](#input\_firewall\_settings) | Firewall configuration: public access and trusted-service bypass. Custom 2-field shape for Container Registry — the standard pattern's `allowed_subnet_ids` is omitted because Azure deprecated VNet rules for ACR and the azurerm provider no longer exposes them. `public_network_access_enabled = false` keeps the registry private (accessed only via private endpoint) and requires `sku_name = 'Premium'`. `trusted_services_bypass_firewall_enabled` only applies on Premium in private mode. | <pre>object({<br/>    public_network_access_enabled            = optional(bool, false)<br/>    trusted_services_bypass_firewall_enabled = optional(bool, true)<br/>  })</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. If set, this value is used for the resource name. | `string` | `null` | no |
| <a name="input_private_endpoint_settings"></a> [private\_endpoint\_settings](#input\_private\_endpoint\_settings) | Settings for the private endpoint. Required when `sku_name` is `Premium`; must be null otherwise (Basic/Standard tiers do not support private endpoints). `subnet_id` is the resource ID of the subnet where the PEP NIC lands. `private_dns_zone_ids` maps each required subresource to its private DNS zone resource ID. | <pre>object({<br/>    subnet_id = string<br/>    private_dns_zone_ids = object({<br/>      registry = string<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of the container registry. Possible values are 'Basic', 'Standard' and 'Premium'. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the container registry. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Container Registry. |
| <a name="output_login_server"></a> [login\_server](#output\_login\_server) | The URL that can be used to log into the container registry. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Container Registry. |
| <a name="output_workload"></a> [workload](#output\_workload) | The Container Registry workload. |
<!-- END_TF_DOCS -->

## How to use it?

Private endpoint support for Azure Container Registry is gated by tier — only the **Premium** SKU supports private endpoints. The module reflects this with `private_endpoint_settings`: it is **optional on Premium** (a Premium registry can be public-only, private with PEP, or both) and must be **null on Basic/Standard**. A plan-time precondition enforces the SKU gating. The examples below assume the relevant subnet and the `privatelink.azurecr.io` DNS zone already exist.

### Premium SKU with Private Endpoint Only

```hcl
module "container_registry" {
  source = "git::github.com/Nmbrs/tf-modules//azure/container_registry"

  workload            = "contoso"
  resource_group_name = "rg-containerimages-prod"
  location            = "westeurope"
  environment         = "prod"
  company_prefix      = "nmbrs"

  sku_name = "Premium"

  firewall_settings = {
    public_network_access_enabled            = false
    trusted_services_bypass_firewall_enabled = true
  }

  private_endpoint_settings = {
    subnet_id = "/subscriptions/.../subnets/snet-private-endpoints"
    private_dns_zone_ids = {
      registry = module.dns_zone_acr.id
    }
  }
}
```

### Premium SKU with Public Access (no private endpoint)

```hcl
module "container_registry" {
  source = "git::github.com/Nmbrs/tf-modules//azure/container_registry"

  workload            = "contoso"
  resource_group_name = "rg-containerimages-prod"
  location            = "westeurope"
  environment         = "prod"
  company_prefix      = "nmbrs"

  sku_name = "Premium"

  firewall_settings = {
    public_network_access_enabled            = true
    trusted_services_bypass_firewall_enabled = false
  }
}
```

### Basic SKU (Public Access Only)

```hcl
module "container_registry" {
  source = "git::github.com/Nmbrs/tf-modules//azure/container_registry"

  workload            = "appimages"
  resource_group_name = "rg-containerimages-dev"
  location            = "westeurope"
  environment         = "dev"
  company_prefix      = "nmbrs"

  sku_name = "Basic"

  firewall_settings = {
    public_network_access_enabled            = true
    trusted_services_bypass_firewall_enabled = false
  }
}
```

### With Override Name

```hcl
module "container_registry" {
  source = "git::github.com/Nmbrs/tf-modules//azure/container_registry"

  override_name       = "crcustomname12345"
  resource_group_name = "rg-containerimages-test"
  location            = "westeurope"
  environment         = "test"

  sku_name = "Premium"

  firewall_settings = {
    public_network_access_enabled            = false
    trusted_services_bypass_firewall_enabled = true
  }
}
```
