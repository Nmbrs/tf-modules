# Azure DNS Zone Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

---

> A terraform module to support the creation of a DNS Zone in Azure.

## Module Input variables

- `name` - Name of the resource group. It must follow the CAF naming convention.
- `resource_group_name` - The name of an existing Resource Group.
- `tags` - A mapping of tags which should be assigned to the desired resource.

## Module Output Variables

- `name` - The name of the DNS Zone. Must be a valid domain name.
- `id` - The DNS Zone name.
- `max_number_of_record_sets` - Maximum number of Records in the zone.
- `number_of_record_sets` - The number of records already in the zone.
- `name_servers` - A list of values that make up the NS record for the zone.

## How to use it?

Fundamentally, you need to declare the module and pass the following variables in your Terraform service template:

```hcl
module "dns_zone" {
  source              = "../tf-modules/azure/dns_zone"
  name                = "my.domain.com"
  resource_group_name = "rg-demo-staging"
  tags                = {
    my_tags: "value"
  }
}
```

## DNS Zone naming rules:

The following rules should be applied when defining a name for the DNS Zone:

- It must be between 3 and 24 characters.
- The last TLD (Top level domain) must be at least 2 characters long and no more than 6 characters long. It must also contain only letters.
- It must contain no more than 2 subdomains. Only letters, digits, and dashes are allowed in the subdomain name. However, the name must not end or begin with dashes.

### Valid Examples

- subomain1.sudomain2.com
- contoso.co.uk
- example.com
