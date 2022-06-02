# Azure Resource Group Module

<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg" />
  <a href="LICENSE.md" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
</p>

---

> A terraform module to support the creation of a repository in Github.

## Module Input variables

- `name` - Name of the repository.
- `description` - Description of the repository
- `visibility` - Private or public repository
- `owner` - The owner organization in Github
- `repository` - The template from which the new repositories will be based on

## How to use it?

Fundamentally, you need to declare the module and pass the following variables in your Terraform service template:

```hcl
module "github_repo" {
  source = "git::github.com/Nmbrs/tf-modules//github"
  repos  = var.repos
}

variable "repos" {
  type        = map(any)
  description = "List of repos"
  default = {
    repo1 = {
      name          = "test"
      description   = "test1 repo"
      repo_template = "template-repo"
      visibility    = "private"
    }
    repo2 = {
      name          = "test2"
      description   = "test2 repo"
      repo_template = "template-repo"
      visibility    = "public"
    }
  }
}
```
