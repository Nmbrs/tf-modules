# Azure Container Registry Module

## Summary

This module creates an Azure Container Registry with flexible naming options and SKU-based configuration. The module enforces sensible defaults for security (admin user disabled; private-by-default on Premium) and validates SKU-aware constraints at plan time.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## How to use it?

A number of code snippets demonstrating different use cases for the module have been included to help you understand how to use the module in Terraform.

### Premium SKU with Private Access

```hcl
module "container_registry" {
  source = "git::github.com/Nmbrs/tf-modules//azure/container_registry"

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
  source = "git::github.com/Nmbrs/tf-modules//azure/container_registry"

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
  source = "git::github.com/Nmbrs/tf-modules//azure/container_registry"

  override_name       = "crcustomname12345"
  resource_group_name = "rg-containerimages-test"
  location            = "westeurope"
  environment         = "test"

  sku_name                                 = "Premium"
  public_network_access_enabled            = false
  trusted_services_bypass_firewall_enabled = true
}
```
