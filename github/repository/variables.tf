variable "name" {
  type        = string
  description = "Name of the repository"

  validation {
    condition     = can(coalesce(var.name))
    error_message = format("Invalid value '%s' for variable 'name'. They must be non-empty string values.", var.name)
  }
}

variable "description" {
  type        = string
  description = "Description of the repository"
}

variable "visibility" {
  type        = string
  description = "Describes visibility."

  validation {
    condition     = contains(["internal", "private"], var.visibility)
    error_message = format("Invalid value '%s' for variable 'visibility', valid options are 'internal', 'private'.", var.visibility)
  }
}

variable "owner" {
  type        = string
  description = "The owner of the repository"

  validation {
    condition     = can(coalesce(var.owner))
    error_message = format("Invalid value '%s' for variable 'owner'. They must be non-empty string values.", var.owner)
  }
}

variable "purpose" {
  description = "Describes if the repo is used internally only or not"
  type        = string

  validation {
    condition     = contains(["internal", "tool", "poc", "product"], var.purpose)
    error_message = format("Invalid value '%s' for variable 'visibility', valid options are 'internal', 'tool', 'poc', 'product'.", var.purpose)
  }
}

variable "rulesets_enabled" {
  description = "Enable or disable branch protection rules for this repository."
  type        = bool
  default     = true
}

variable "branch_deletion_enabled" {
  description = "Allow or prevent deletion of branches in this repository."
  type        = bool
  default     = true
}

variable "is_small_team" {
  description = "Describes if the repo is used by a small team or not."
  type        = bool
  default     = false
}