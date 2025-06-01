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