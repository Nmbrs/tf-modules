terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 1.3.0"
    }
  }

  required_version = ">= 1.5.0, < 2.0.0"
}
