terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.117"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~> 2.2.0"
    }
  }

  required_version = ">= 1.5.0, < 2.0.0"
}
