variable "repositories" {
  type = list(object({
    name        = string
    description = string
    template    = string
    visibility  = string
    squad       = string
  }))
  description = "List of values needed to create the repo"
  default     = []

  validation {
    condition     = alltrue([for repository in var.repositories : can(coalesce(repository.name))])
    error_message = "At least one 'name' property from 'repositories' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for repository in var.repositories : repository.name]) == length(distinct([for repository in var.repositories : trimspace(lower(repository.name))]))
    error_message = "At least one 'name' property from 'repositories' is duplicated. They must be unique."
  }

  validation {
    condition     = alltrue([for repository in var.repositories : can(coalesce(repository.description))])
    error_message = "At least one 'description' property from 'repositories' is invalid.  They must be non-empty string values."
  }

  validation {
    condition     = alltrue([for repository in var.repositories : contains(["dotnet-template", "golang-template", "nodejs-template"], repository.template)])
    error_message = "At least one 'template' property from 'repositories' is invalid. Valid options are 'golang-template', 'dotnet-template'."
  }

  validation {
    condition     = alltrue([for repository in var.repositories : contains(["public", "private"], repository.visibility)])
    error_message = "At least one 'visibility' property from 'repositories' is invalid. Valid options are 'public', 'private'."
  }

  validation {
    condition     = alltrue([for repository in var.repositories : can(coalesce(repository.squad))])
    error_message = "At least one 'squad' property from 'repositories' is invalid. They must be non-empty string values."
  }
}

variable "github_owner" {
  type        = string
  description = "GitHub Nmbrs owner name"
}

variable "github_token" {
  type        = string
  description = "GitHub Nmbrs token to provision and configure resources."
}
