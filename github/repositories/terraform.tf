terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.6"
    }
  }

  required_version = ">= 1.5.0, < 2.0.0"
}
