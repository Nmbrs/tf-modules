variable "name" {
  type        = string
  description = "The name of the GitHub team. Must follow the format 'gh-abc-abc', where 'abc' are alphanumeric strings separated by hyphens."

  # 1. Must start with 'gh-'
  validation {
    condition     = startswith(var.name, "gh-")
    error_message = format("Invalid value '%s' for variable 'name'. It must start with the prefix 'gh-'.", var.name)
  }

  # 2. Must only contain alphanumeric characters and hyphens
  validation {
    condition     = can(regex("^gh-[a-zA-Z0-9-]+$", var.name))
    error_message = format("Invalid value '%s' for variable 'name'. Only alphanumeric characters and hyphens are allowed.", var.name)
  }

  # 3. Must have at least two alphanumeric parts after 'gh-', separated by hyphens
  validation {
    condition     = can(regex("^gh-[a-zA-Z0-9]+(-[a-zA-Z0-9]+)+$", var.name))
    error_message = format("Invalid value '%s' for variable 'name'. It must follow the format 'gh-xxx-xxx' with at least two alphanumeric parts separated by hyphens.", var.name)
  }
}

variable "description" {
  type        = string
  description = "A brief description of the GitHub team's purpose. This will be displayed in the GitHub UI."
}

variable "parent_team" {
  type        = optional(string, null)
  description = "The slug of the parent GitHub team, if the current team is a child team. Use null if this team has no parent."
}