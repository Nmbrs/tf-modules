terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.63"
    }
  }

  required_version = ">= 1.5.0, < 2.0.0"
}
