variable "name" {
  description = "(Required) The Azure resource group name to be used. The name must follow the CAF naming convention"
  type        = string
}

variable "project" {
  description = "Name of the project to which the resources should be assigned."
  type        = string

  validation {
    condition     = can(coalesce(var.project))
    error_message = "The 'project' value is invalid. It must be a non-empty string."
  }
}

variable "squad" {
  description = "Name of the project to which the resources should be assigned."
  type        = string

  validation {
    condition     = can(coalesce(var.squad))
    error_message = "The 'squad' value is invalid. It must be a non-empty string."
  }
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string

  validation {
    condition     = contains(["Dev", "Prod", "Staging", "Test", ], var.environment)
    error_message = "The 'environment' value is invalid. Valid options are 'Dev', 'Prod','Staging', 'Test'."
  }
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the desired resource."
  type        = map(string)

  validation {
    condition     = alltrue([for tag in var.tags : can(coalesce(tag))])
    error_message = "At least on tag value from 'tags' is invalid. They must be a non-empty string."
  }
}

variable "location" {
  # For a complete list of available Azure regions run at cli:  
  # az account list-locations  --query "[].{displayName:displayName, location:name}" --output table
  description = "The Azure Region where the resource should exist."
  type        = string

  validation {
    condition     = can(coalesce(var.location))
    error_message = "The 'location' value is invalid. It must be a non-empty string."
  }
}
