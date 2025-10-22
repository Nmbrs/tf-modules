variable "workload" {
  description = "The workload name for the Key Vault Managed HSM."
  type        = string

  validation {
    condition     = length(var.workload) <= 8
    error_message = format("Invalid value '%s' for variable 'workload'. It must contain no more than 8 characters.", var.workload)
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault Managed HSM."
}

variable "location" {
  description = "The Azure location where the Key Vault Managed HSM will be deployed. For a list of locations, use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod", "sand", "stag"], var.environment)
    error_message = format("Invalid value '%s' for variable 'environment'. Valid options are 'dev', 'test', 'prod', 'sand', 'stag'.", var.environment)
  }
}

variable "admin_group_names" {
  description = "List of Azure AD security group names that will have admin access to the Key Vault Managed HSM."
  type        = list(string)

  validation {
    condition     = length(var.admin_group_names) > 0
    error_message = "At least one admin group name must be specified."
  }

  validation {
    condition     = alltrue([for group in var.admin_group_names : can(coalesce(group)) && length(trimspace(group)) > 0])
    error_message = "All admin group names must be non-empty strings."
  }
}

variable "override_name" {
  description = "Optional override for the Key Vault Managed HSM name to bypass naming convention."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.override_name == null || try(length(trimspace(var.override_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'override_name'. It must be null or a non-empty string.", coalesce(var.override_name, "null"))
  }
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

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault Managed HSM. Currently, only 'Standard_B1' is supported by Azure."
  type        = string
  default     = "Standard_B1"
  nullable    = false

  validation {
    condition     = var.sku_name == "Standard_B1"
    error_message = format("Invalid value '%s' for variable 'sku_name'. Currently, only 'Standard_B1' is supported.", var.sku_name)
  }
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for soft delete. Must be between 7 and 90 days."
  type        = number
  default     = 90
  nullable    = false

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = format("Invalid value '%s' for variable 'soft_delete_retention_days'. Must be between 7 and 90 days.", var.soft_delete_retention_days)
  }
}

variable "purge_protection_enabled" {
  description = "Is Purge Protection enabled for this Key Vault Managed HSM? When enabled, the HSM and its items cannot be permanently deleted."
  type        = bool
  default     = true
  nullable    = false
}
