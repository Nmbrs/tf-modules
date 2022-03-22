variable "name" {
  description = "Name of the resource group. It must follow the CAF naming convention."
  type        = string
}

variable "product" {
  description = "Name of the product to which the resources belongs."
  type        = string

  validation {
    condition     = can(coalesce(var.product))
    error_message = "The 'product' value is invalid. It must be a non-empty string."
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
  description = "Name of the country to which the resources belongs."
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
    condition     = contains(["Dev", "Prod", "Staging", "Test"], var.environment)
    error_message = "The 'environment' value is invalid. Valid options are 'Dev', 'Prod','Staging', 'Test'."
  }
}

variable "extra_tags" {
  description = "(Optional) A extra mapping of tags which should be assigned to the desired resource."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for tag in var.extra_tags : can(coalesce(var.extra_tags))])
    error_message = "At least on tag value from 'extra_tags' is invalid. They must be non-empty string values."
  }
}

variable "location" {
  # For a complete list of available Azure regions run at cli:  
  # az account list-locations  --query "[].{displayName:displayName, location:name}" --output table
  description = "(Optional) The Azure Region where the resource should exist."
  type        = string
  default     = "westeurope"

  validation {
    condition     = contains(["westeurope", "northeurope"], var.location)
    error_message = "The 'location' value is invalid. It must be a non-empty string."
  }
}
