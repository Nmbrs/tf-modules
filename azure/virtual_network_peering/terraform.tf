terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "~> 3.117"
      configuration_aliases = [azurerm.source, azurerm.destination]
    }
  }

  required_version = ">= 1.5.0, < 2.0.0"
}
