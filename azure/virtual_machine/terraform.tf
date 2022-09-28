terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.6"
    }

    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview-3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.0"
    }

    random = {
      source = "hashicorp/random"
      version   = "~> 3.4.0"
    }
  }

  required_version = ">= 1.0.0, < 2.0.0"
}

provider "azurerm" {
  features {
  }
}
