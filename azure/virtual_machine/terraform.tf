terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.117"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }

  required_version = ">= 1.5.0, < 2.0.0"
}
