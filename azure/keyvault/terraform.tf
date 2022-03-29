terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.98.0"
    }

    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview-2"
    }
  }

  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
