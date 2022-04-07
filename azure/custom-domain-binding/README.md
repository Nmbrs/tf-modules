# Azure Custom Domain Binding Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

This module supports the creation of custom domain binding, DNS records and SSL binding of the app services with a certificate.

## How to use it?

Fundamentally, you need to declare the modules and pass the following variables in your Terraform service template:

```hcl
module "sslbinding" {
  source            = "git::github.com/Nmbrs/repository/github/tf-modules/azure/custom-domain-binding"
  apps = {      
	  web = {
      custom_domain = "*.mycustomdomain.com" #This is the custom domain that you want for the app
      cname         = "*"                    #This is the name of the DNS record that will be created.
    }
    worker = {
      custom_domain = "worker.mycustomdomain.com" #This is the custom domain that you want for the app
      cname         = "worker"                    #This is the name of the DNS record that will be created.
    }
    mobile = {
      custom_domain = "mobile.mycustomdomain.com" #This is the custom domain that you want for the app
      cname         = "mobile"                    #This is the name of the DNS record that will be created.
    }
    api = {
      custom_domain = "api.mycustomdomain.com" #This is the custom domain that you want for the app
      cname         = "api"                    #This is the name of the DNS record that will be created.
    }
  }
  dns_zone_name                       = "my_dns_name"                         #DNS zone that will be used for the custom domain
  dns_zone_resource_group             = "my_dns_zone_resource_group"          #DNS zone resource group
  ttl                                 = 300
  resource_group                      = "rg-resourcegroup"                    #Resource group where the app service is
  certificate_keyvault_name           = "certificate_keyvault_name"           #Name of the keyvault where the certificate is stored
  certificate_keyvault_resource_group = "certificate_keyvault_resource_group" #Resource group of the keyvault
  certificate_name                    = "certificate_name"                    #Name of the certificate inside the keyvault
  location                            = "westeurope"
  tags                                = {
    Country     = "country"
    Squad       = "squad"
    Product     = "product"
    Environment = "environment"
  }
  app_name                            = "name of the application"
  app_default_site_hostname           = "app.azurewebsites.net"
}
```
