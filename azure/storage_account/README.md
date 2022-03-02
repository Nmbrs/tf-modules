# Azure Storage Account Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

This module supports the creation of Microsoft Storage Account in an existent Azure resource group name.

## How to use it?

Fundamentally, you need to declare the module and pass the following variables in your Terraform service template:

```hcl
module "storage_account" {
  source              = "../tf-modules/azure/storage-account"storage_account"
  name                = "sauniquename123"
  location            = "West Europe"
  resource_group_name = "rg-my-resource-group"
  tags = {
    my_tag : "my_tag_value"
  }
  account_kind     = "Storage"
  account_tier     = "Standard"
  replication_type = "GRS"
}
```
