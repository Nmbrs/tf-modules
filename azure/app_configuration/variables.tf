variable "public_network_access_enabled" {
  description = "A condition to indicate if the App Configuration will have public network access (defaults to false)."
  type        = bool
  default     = false
}
variable "sku_name" {
  description = "The SKU name of the App Configuration."
  type        = string
  default     = "developer"
  validation {
    condition     = contains(["free", "developer", "standard", "premium"], lower(var.sku_name))
    error_message = "sku_name must be one of 'free', 'developer', 'standard', or 'premium'."
  }
}

variable "resource_group_name" {
  description = "The name of an existing Resource Group."
  type        = string

  validation {
    condition     = can(coalesce(var.resource_group_name))
    error_message = "The resource group name must be a non-empty string."
  }
}

variable "workload" {
  description = "The workload name of the App Configuration."
  type        = string

  validation {
    condition     = can(coalesce(var.workload))
    error_message = "The workload value must be a non-empty string."
  }
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exhaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string

  validation {
    condition     = can(coalesce(var.location))
    error_message = "The location must be a non-empty string."
  }
}

variable "override_name" {
  description = "Override the name of the App Configuration, to bypass naming convention."
  type        = string
  default     = null
  nullable    = true
}

variable "company_prefix" {
  description = "Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters."
  type        = string
  default     = "nmbrs"
  validation {
    condition     = length(trimspace(var.company_prefix)) > 0 && length(var.company_prefix) <= 5
    error_message = "company_prefix must be a non-empty string with a maximum of 5 characters."
  }
}
