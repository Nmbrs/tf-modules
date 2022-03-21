variable "name" {
  description = "(Required) The Azure resource group name to be used. The name must follow the CAF naming convention"
  type        = string
}

variable "product" {
  description = "Name of the project to which the resources belongs."
  type        = string

  validation {
    condition     = can(coalesce(var.product))
    error_message = "The 'project' value is invalid. It must be a non-empty string."
  }
}

variable "squad" {
  description = "Name of the squad to which the resources belongs."
  type        = string

  validation {
    condition     = can(coalesce(var.squad))
    error_message = "The 'squad' value is invalid. It must be a non-empty string."
  }
}

variable "country" {
  description = "Name of the contry to which the resources belongs."
  type        = string

  validation {
    condition     = can(coalesce(var.country))
    error_message = "The 'squad' value is invalid. It must be a non-empty string."
  }
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string

  validation {
    condition     = contains(["dev", "prod", "staging", "test", ], var.environment)
    error_message = "The 'environment' value is invalid. Valid options are 'dev', 'prod','staging', 'test'."
  }
}

variable "extra_tags" {
  description = "A mapping of tags which should be assigned to the desired resource."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for tag in var.extra_tags : can(coalesce(tag))])
    error_message = "At least on tag value from 'tags' is invalid. They must be a non-empty string."
  }
}
