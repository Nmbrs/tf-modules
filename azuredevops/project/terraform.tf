terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 1.4.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  required_version = ">= 1.5.0, < 2.0.0"
}
