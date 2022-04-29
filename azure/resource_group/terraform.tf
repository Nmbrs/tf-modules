terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview-2"
    }
  }

  required_version = ">= 1.0.0"
}
