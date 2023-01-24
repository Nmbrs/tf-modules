terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.6"
    }
  }

  required_version = ">= 1.3.0, < 2.0.0"
}

provider "azurerm" {
  features {
  }
}
