terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.5.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview-3"
    }
  }

  required_version = ">= 1.0.0"
}

