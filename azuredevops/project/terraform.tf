terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "1.2.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.12.0"
    }
  }

  required_version = ">= 1.5.0, < 2.0.0"
}
