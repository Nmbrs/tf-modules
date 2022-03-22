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
- `environment` - The environment in which the resource should be provisioned. Valid options are 'Dev', 'Kitchen', 'Production','Staging', 'Test'.
- `country` - Name of the country to which the resources belongs.
- `squad` - Name of the squad to which the resources belongs.
- `product` - Name of the product to which the resources belongs.
- `extra_tags` - (Optional) A extra mapping of tags which should be assigned to the desired resource.

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
  environment               = "Dev"
  country                   = "nl"
  squad                     = "infra"
  product                   = "internal"
  extra_tags = {
    extra_tag_01 = "value_01"
    extra_tag_02 = "value_02"
    extra_tag_03 = "value_03"
  }
}
```
