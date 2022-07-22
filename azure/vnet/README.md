# Azure Vnet Module
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

This module supports the creation of Microsoft Azure vnet in an existent Azure resource group name. Also supports
the creationg of vnet subnets and vnet peerings (within same Azure resource group), and enables the vnet service
delegation, when needed.

## How to use it?

Fundamentaly, you need to declare the module and pass the following variables in your Terraform service template:

```terraform
module "nmbrs_virtualnetwork" {
  source              = "../terraform-modules/azure/vnet"
  project             = var.project
  resource_group_name = "rg-network-dev"
  virtual_networks    = var.virtual_networks
  environment         = var.environment
  subnets             = var.subnets
  vnets_to_peer       = var.vnets_to_peer
}
```

The ```virtual_networks```, ```subnets``` and ```vnets_to_peer``` are **lists** of data structures that contains the
required information to provision the resources on Azure.

Here is an example

```diff
variable "virtual_networks" {
  default = {
+  vnet1 = {
      id            = "1"
      prefix        = "kitchens"
      address_space = ["10.16.0.0/16"]
    }

-   vnet2 = {
      id            = "2"
      prefix        = "microservices"
      address_space = ["10.17.0.0/16"]
    }
  }
}

variable "subnets" {
  default = {
    snet1 = {
+     vnet_key         = "vnet1"           #(Mandatory) 
      name             = "infra"           #(Mandatory) 
      address_prefixes = ["10.16.1.0/24"] #(Mandatory) 
      #nsg_key           = "nsg1"                                 #(Optional) delete this line for no NSG
      delegation = [
        {
          name = "infradelegation" #(Required) A name for this delegation.
          service_delegation = [
            {
              name    = "Microsoft.Web/serverFarms"                          # (Required) The name of service to delegate to. 
              actions = ["Microsoft.Network/virtualNetworks/subnets/action"] # (Required) A list of Actions which should be delegated. Possible values include Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action, Microsoft.Network/virtualNetworks/subnets/action and Microsoft.Network/virtualNetworks/subnets/join/action.
            },
          ]
        },
      ]
    }

    snet2 = {
+     vnet_key         = "vnet1"
      name             = "core"
      address_prefixes = ["10.16.2.0/24"]
      #nsg_key        = "nsg1"
    }

    snet3 = {
+     vnet_key         = "vnet1"
      name             = "mobile"
      address_prefixes = ["10.16.3.0/24"]
      #nsg_key        = "nsg1"
    }

  }
}

variable "vnets_to_peer" {
  default = {
    vnets_to_peer1 = {
+     vnet_key         = "vnet1"
      remote_vnet_name = "vnet-microservices"
    }

-   vnets_to_peer2 = {
      vnet_key         = "vnet2"
      remote_vnet_name = "vnet-kitchens"
    }
  }
}
````



