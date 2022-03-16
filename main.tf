terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {
  }
}

module "resource_group" {
  source   = "git::github.com/Nmbrs/tf-modules/azure/resource-group"
  name     = "rg-demo-pr"
  location = "westeurope"
   tags = {
    Country : "NL"
    Squad : "Infra"
    Product : "Internal"
    Environment : "Dev"
  }
}


module "keyvault" {
  source              = "./azure/keyvault"
  name                = "kv-demo-pr-dev"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags = module.resource_group.tags

  writers = ["SG-SquadInfra"]
  readers = ["SG-SquadInfra"]
}
