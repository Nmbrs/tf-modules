# Azure Storage Account Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

This module supports the creation of DNS Records in an existent Azure DNS Zone.

## How to use it?

Fundamentally, you need to declare the module and pass the following variables in your Terraform service template:

```hcl
module "dns" {
  source   = "../tf-modules/azure/dns-records"
  dns_zone_name = "domain.com"
  dns_zone_rg   = "rg-domainzone"
  a = {
    web = {
      name    = "web"
      records = ["192.168.1.1"]
      ttl     = 300
    }
  }

  cname = {
    api = {
      name   = "api"
      record = "api.azurewebsites.net"
      ttl    = 300
    }
  }
  txt = {
    acme = {
      name   = "_acme-challenge"
      record = ["__2asdnkaASAFc-Xx8ASFASGFmka-EwvGO5asdqwWfasfdR64No"]
      ttl    = 300
    }
  }
}
}
```


