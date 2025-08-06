variable "enterprise_name" {
  type = string
}

variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "display_name" {
  type = string
}


variable "billing_email" {
  type    = string
  default = ""
}


variable "rulesets_settings" {
  type = object({
    protect_default_branches_small_teams = object({
      branch_names           = list(string)
      protected_repositories = list(string)
      excluded_repositories  = list(string)
      bypass_teams           = list(string)
    })
    protect_default_branches_large_teams = object({
      branch_names           = list(string)
      protected_repositories = list(string)
      excluded_repositories  = list(string)
      bypass_teams           = list(string)
    })
  })
}

