terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.116"
    }
  }

  required_version = ">= 1.5.0, < 2.0.0"
}
