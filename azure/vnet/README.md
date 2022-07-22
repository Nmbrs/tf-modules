# Azure Vnet Module
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

The `virtual_network` module supports the creation of Microsoft Azure virtual network in an existent Azure resource group name. This module also supports
the creation of vnet subnets  and enables the vnet service delegation, when needed.

## Module Input variables

- `name` - The name of the virtual network.
- `resource_group_name` - The name of the resource group in which to create the virtual network.
- `environment` - (Optional) The environment in which the resource should be provisioned.
- `address_spaces` - The address space that is used the virtual network.
- `extra_tags` - List of additional resource tags.
- `subnets` - "List of objects that represent the configuration of each subnet."

## Module Output Variables

- `name` - Specifies the name of the virtual network
- `id` - Specifies the resource id of the virtual network
- `subnet_ids` - Contains a list of the the resource id of the subnets

## How to use it?

Here is a sample that helps illustrating how to user the module on a Terraform service

```hcl
module "virtual_network" {
  source              = "git::github.com/Nmbrs/tf-modules//azure/virtual_network"
  resource_group_name = module.rg-01.name
  name                = "vnet-dev-westeu-1000"
  address_spaces      = ["10.150.0.0/16"]
  environment         = "dev"
  subnets = [{
    name                                           = "snet-dev-westeu-1000"
    address_prefixes                               = ["10.150.100.0/24"]
    enforce_private_link_service_network_policies  = false
    enforce_private_link_endpoint_network_policies = false
    service_endpoints                              = ["Microsoft.EventHub", "Microsoft.Web", "Microsoft.Sql"]
    delegations                                    = ["Microsoft.ContainerInstance/containerGroups", "Microsoft.Web/serverFarms", "Microsoft.Databricks/workspaces"]
  }]
```


