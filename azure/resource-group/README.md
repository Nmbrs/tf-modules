# Azure Resource Group Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

# ⚠️ This module is deprecated and `azurerm_resource_group` published on [the Terraform registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) should be used instead. This module will not have active support any more.


---

> A terraform module to support the creation of a resource group in Azure.

## Module Input variables

- `project` - Project name.
- `environment` - Environment name.
- `location` - Specifies the Azure Region where the resource should exists.
- `tags` - List of mandatory resource tags.

## Module Output Variables

- `resource_group_name` - Name
- `resource_group_id` - id
- `resource_group_location` - location

## How to use it?

Fundamentally, you need to declare the module and pass the following variables in your Terraform service template:

```hcl
module "resource-group" {
  source                    = "../tf-modules/azure/resource-group"
  project                   = "my_project"
  environment               = "production"
  location                  = "West Europe"
  tags                      = {
    country : "nl"
    squad : "infra"
    product : "test-product"
    environment : "prod"
  }
}
```
