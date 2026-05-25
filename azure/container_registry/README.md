<!-- BEGIN_TF_DOCS -->
# Azure Container Registry Module

This module creates an Azure Container Registry with flexible naming options and SKU-based configuration.

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
| [azurerm_container_registry.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_company_prefix"></a> [company\_prefix](#input\_company\_prefix) | Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resource should be provisioned. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location where the resources will be deployed in Azure. For an exhaustive list of locations, please use the command 'az account list-locations -o table'. | `string` | n/a | yes |
| <a name="input_override_name"></a> [override\_name](#input\_override\_name) | Optional override for naming logic. If set, this value is used for the resource name. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed. Default 'false' keeps the registry private (accessed only via private endpoint) and requires sku\_name = 'Premium'. For 'Basic' or 'Standard' you must explicitly set this to true, since those SKUs do not support private link. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of an existing Resource Group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of the container registry. Possible values are 'Basic', 'Standard' and 'Premium'. | `string` | n/a | yes |
| <a name="input_trusted_services_bypass_firewall_enabled"></a> [trusted\_services\_bypass\_firewall\_enabled](#input\_trusted\_services\_bypass\_firewall\_enabled) | Allow trusted Microsoft services (e.g. AKS, ACI) to reach the registry despite the firewall. Only valid on Premium in private mode (public\_network\_access\_enabled = false); has no effect on a public registry. | `bool` | `true` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | The workload name of the container registry. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Container Registry. |
| <a name="output_login_server"></a> [login\_server](#output\_login\_server) | The URL that can be used to log into the container registry. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Container Registry. |

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Premium SKU with Private Access
```hcl
module "container_registry" {
  source = "../../modules/azure/container_registry"

  workload            = "contoso"
  resource_group_name = "rg-containerimages-prod"
  location            = "westeurope"
  environment         = "prod"
  company_prefix      = "nmbrs"

  sku_name                                 = "Premium"
  public_network_access_enabled            = false
  trusted_services_bypass_firewall_enabled = true
}
```

### Basic SKU (Public Access Only)
```hcl
module "container_registry" {
  source = "../../modules/azure/container_registry"

  workload            = "appimages"
  resource_group_name = "rg-containerimages-dev"
  location            = "westeurope"
  environment         = "dev"
  company_prefix      = "nmbrs"

  sku_name                                 = "Basic"
  public_network_access_enabled            = true
  trusted_services_bypass_firewall_enabled = false
}
```

### With Override Name
```hcl
module "container_registry" {
  source = "../../modules/azure/container_registry"

  override_name       = "crcustomname12345"
  resource_group_name = "rg-containerimages-test"
  location            = "westeurope"
  environment         = "test"

  sku_name                                 = "Premium"
  public_network_access_enabled            = false
  trusted_services_bypass_firewall_enabled = true
}
```
<!-- END_TF_DOCS -->
