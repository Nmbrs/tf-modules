terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~>1.14.0"
    }
  }

  required_version = ">= 1.5.0, < 2.0.0"
}
