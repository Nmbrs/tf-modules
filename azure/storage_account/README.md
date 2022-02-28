# Azure Storage Account Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

This module supports the creation of Microsoft Storage Account an existent Azure resource group name.

## How to use it?

Fundamentally, you need to declare the module and pass the following variables in your Terraform service template:

```hcl
module "storage_account" {
  source              = "../tf-modules/azure/storage-account"
  environment         = "my_environment"
  project             = "my_project"
  location            = "West Europe"
  resource_group_name = "rg-my-resource-group"
  tags = {
    my_tag : "my_tag_value"
  }
  kind                      = "StorageV2"
  account_tier              = "Standard"
  replication_type          = "LRS"
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true
}
```

### Naming

This module follows nmbrs naming convention but due to some restrictions imposed by [Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftstorage) its not possible to follow it strictly.

To make it easier to manage the module applies the following rule:

- storage account name = prefix + random_id
  - prefix= sanmbrs + environment + project (max length = 20 characters)
  - random id = 4 hexadecimal random characters
