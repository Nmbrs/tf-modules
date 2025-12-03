variable "workload" {
  description = "The workload name of the resource group."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false
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
