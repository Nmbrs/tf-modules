# Azure Resource Group Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

This module supports the creation of a resource group.

## How to use it?

Fundamentally, you need to declare the module and pass the following variables in your Terraform service template:

```hcl
module "resource-group" {
  source                    = "../tf-modules/azure/resource-group"
  name                      = "rg-my-resource-group"
  location                  = "West Europe"
  tags                      = {
    country : "nl"
    squad : "infra"
    product : "test-product"
    environment : "prod"
  }
}
```

### Tag Validation

This module follows nmbrs strategy and validates if the following tags exists and they are not empty:

- environment
- country
- product
- environment
