# Azure Resource Group Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

---

> A terraform module to support the creation of a resource group in Azure.

## Module Input variables

- `name` - Name of the resource group. It must follow the CAF naming convention.
- `location` - (Optional) Specifies the Azure Region where the resource should exists.
- `environment` - The environment in which the resource should be provisioned.
- `country` - Name of the contry to which the resources belongs.
- `squad` - Name of the squad to which the resources belongs.
- `product` - Name of the product to which the resources belongs.
- `tags` - List of mandatory resource tags.

## Module Output Variables

- `name` - Name
- `id` - id
- `location` - location
- `tags` - tags

## How to use it?

Fundamentally, you need to declare the module and pass the following variables in your Terraform service template:

```hcl
module "resource-group" {
  source                    = "../tf-modules/azure/resource-group"
  name                      = "rg-my_project-dev"
  location                  = "West Europe"
  environment               = "Dev"
  country                   = "nl"
  squad                     = "infra"
  product                   = "internal"
}
```
