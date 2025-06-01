variable "type" {
  description = "Type of ruleset to apply."
  type        = string
  default     = "protect_all_main_branches"

  validation {
    condition = contains(["protect_all_main_branches"], var.type)
    error_message = format("Invalid value '%s' for variable 'type', valid options are 'protect_all_main_branches'.", var.type)
  }
}

variable "bypass_teams" {
  description = "List of GitHub admin team slugs to bypass protection rules"
  type        = list(string)

  validation {
    condition     = length(var.bypass_teams) > 0
    error_message = "At least one team slug must be provided in bypass_teams."
  }
}

variable "protected_repositories" {
  description = "List of repositories to apply branch protection to. Use [\"~ALL\"] to target all."
  type        = list(string)
  default     = ["~ALL"]
}

variable "excluded_repositories" {
  description = "List of repositories to exclude from branch protection."
  type        = list(string)
  default     = []
}
