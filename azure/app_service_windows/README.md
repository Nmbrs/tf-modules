# Azure App Service Windows Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

This module supports the creation of a App Service Plan, Multiple App Services in the plan and the vnet association, a Log Analytics Workspace as well as a Application insigths.
It passes values to the custom domain binding module which will take care of the creation of the custom domain, DNS records and SSL binding of the app services with a certificate.

## How to use it?

Fundamentally, you need to declare the modules and pass the following variables in your Terraform service template:

```hcl
module "resource_group" {
  source      = "git::github.com/Nmbrs/tf-modules/azure/resource-group"
  name        = "my_project"
  location    = "westeurope"
  country     = "country"
  environment = "stage"
  product     = "internal"
  squad       = "infra"
}

module "app_service_plan" {
  source                  = "git::github.com/Nmbrs/tf-modules/azure/appservice-windows"
  project                 = "my_project"
  resource_group          = module.resource_group.name
  apps                    = {      
	  web = {
      name          = "web"                  #This is the name of the app itself
      subnet        = "subnet_id"            #This is the subnet that you want to integrate the app service with
      custom_domain = "*.mycustomdomain.com" #This is the custom domain that you want for the app
      cname         = "*"                    #This is the name of the DNS record that will be created.
    }
    worker = {
      name          = "worker"                    #This is the name of the app itself
      subnet        = "subnet_id"                 #This is the subnet that you want to integrate the app service with
      custom_domain = "worker.mycustomdomain.com" #This is the custom domain that you want for the app
      cname         = "worker"                    #This is the name of the DNS record that will be created.
    }
    mobile = {
      name          = "mobile"                    #This is the name of the app itself
      subnet        = "subnet_id"                 #This is the subnet that you want to integrate the app service with
      custom_domain = "mobile.mycustomdomain.com" #This is the custom domain that you want for the app
      cname         = "mobile"                    #This is the name of the DNS record that will be created.
    }
    api = {
      name          = "api"                    #This is the name of the app itself
      subnet        = "subnet_id"              #This is the subnet that you want to integrate the app service with
      custom_domain = "api.mycustomdomain.com" #This is the custom domain that you want for the app
      cname         = "api"                    #This is the name of the DNS record that will be created.
    }
  }
}
  environment                         = "stage"
  sku                                 = "P1v2"
  stack                               = "dotnet"
  dotnetVersion                       = "v4.0"
  tags                                = module.resource_group.tags
  location                            = module.resource_group.location
  dns_zone_name                       = "myzone"
  dns_zone_resource_group             = "myzoneresourcegroup"
  certificate_keyvault_name           = "mykeyvault"
  certificate_keyvault_resource_group = "mykeyvaultresourcegroup"
  certificate_name                    = "mycertificate"
  ttl                                 = 300
}
```
