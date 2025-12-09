variable "override_name" {
  description = "Optional override for naming logic."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.override_name == null || try(length(trimspace(var.override_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'override_name', it must be null or a non-empty string.", coalesce(var.override_name, "null"))
  }
}

variable "workload" {
  description = "Short, descriptive name for the application, service, or workload. Used in resource naming conventions."
  type        = string
  nullable    = true

  validation {
    condition     = var.workload == null || try(length(trimspace(var.workload)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'workload', it must be null or a non-empty string.", coalesce(var.workload, "null"))
  }
}

variable "company_prefix" {
  description = "Short, unique prefix for the company / organization."
  type        = string
  nullable    = true

  validation {
    condition     = var.company_prefix == null || try(length(trimspace(var.company_prefix)) > 0 && length(var.company_prefix) <= 5, false)
    error_message = format("Invalid value '%s' for variable 'company_prefix', it must be a non-empty string with a maximum of 5 characters.", coalesce(var.company_prefix, "null"))
  }
}

variable "sequence_number" {
  description = "A numeric value used to ensure uniqueness for resource names."
  type        = number
  nullable    = true

  validation {
    condition     = var.sequence_number == null || try(var.sequence_number >= 1 && var.sequence_number <= 999, false)
    error_message = format("Invalid value '%s' for variable 'sequence_number', it must be null or a number between 1 and 999.", coalesce(var.sequence_number, "null"))
  }
}

variable "location" {
  description = "Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = format("Invalid value '%s' for variable 'location', it must be a non-empty string.", var.location)
  }
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["dev", "test", "prod", "sand", "stag"], var.environment)
    error_message = format("Invalid value '%s' for variable 'environment'. Valid options are 'dev', 'test', 'prod', 'sand', 'stag'.", var.environment)
  }
}

variable "resource_group_name" {
  description = "Specifies the name of the resource group where the resource should be provisioned."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = format("Invalid value '%s' for variable 'resource_group_name', it must be a non-empty string.", var.resource_group_name)
  }
}

variable "azuread_sql_admin" {
  description = "The name of the admin (Azure AD group) that will be SQL Server admin"
  type        = string
  nullable    = false
}

variable "azuread_authentication_only_enabled" {
  description = "Specifies if only Azure AD authentication is allowed"
  type        = bool
  default     = true
}

variable "auditing_settings" {
  description = "The settings necessary for the storage account auditing. Required for prod and sand environments, optional for others."
  type = object({
    storage_account_name           = string
    storage_account_resource_group = string
  })
  default  = null
  nullable = true
}

variable "local_sql_admin_user_settings" {
  description = "The settings necessary for the local SQL admin creation, the username and the key vault settings for the password."
  type = object({
    local_sql_admin_user = string
    local_sql_admin_user_password = object({
      key_vault_name           = string
      key_vault_resource_group = string
      key_vault_secret_name    = string
    })
  })
}

variable "network_settings" {
  description = "Network configuration settings for the SQL Server, including public access, firewall rules, and allowed subnets."
  type = object({
    public_network_access_enabled            = bool
    trusted_services_bypass_firewall_enabled = bool
    allowed_subnets = list(object({
      subnet_name                = string
      virtual_network_name       = string
      subnet_resource_group_name = string
    }))
  })

  validation {
    condition     = var.network_settings.public_network_access_enabled || length(var.network_settings.allowed_subnets) == 0
    error_message = "Invalid configuration: 'allowed_subnets' can only be specified when 'public_network_access_enabled' is true."
  }
}
