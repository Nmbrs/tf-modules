terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.6"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.2.0"
    }
  }

  required_version = ">= 1.3.0, < 2.0.0"
}

provider "azurerm" {
  features {
  }
}
