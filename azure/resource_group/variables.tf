variable "name" {
  description = "Name of the resource group. It must follow the CAF naming convention."
  type        = string

  validation {
    condition     = can(coalesce(var.name))
    error_message = "The 'name' value is invalid. It must be a non-empty string."
  }
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the desired resource."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for tag in var.tags : can(coalesce(var.tags))])
    error_message = "At least on tag value from 'tags' is invalid. They must be non-empty string values."
  }
}
