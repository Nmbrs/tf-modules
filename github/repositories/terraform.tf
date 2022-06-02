terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.26"
    }
  }

  required_version = ">= 1.0.0, < 2.0.0"
}
