variable "github_owner" {
  description = "GitHub owner name"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

variable "admin_team" {
  description = "GitHub admin Team"
  type        = string
}

variable "admin_username" {
  description = "GitHub admin username"
  type        = string
}