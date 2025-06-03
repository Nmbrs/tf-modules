terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1"
    }
  }


  required_version = ">= 1.5.0, < 2.0.0"
}
