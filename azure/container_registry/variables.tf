variable "workload" {
  description = "The workload name of the container registry."
  type        = string
  nullable    = true

  validation {
    condition     = var.workload == null || try(length(trimspace(var.workload)) > 0 && length(var.workload) <= 13, false)
    error_message = format("Invalid value '%s' for variable 'workload'. It must be a non-empty string with a maximum of 13 characters.", coalesce(var.workload, "null"))
  }

  validation {
    condition     = var.workload == null || !can(regex("[^a-zA-Z0-9]+", var.workload))
    error_message = format("Invalid value '%s' for variable 'workload'. It must only contain letters and numbers.", coalesce(var.workload, "null"))
  }
}

variable "resource_group_name" {
  description = "The name of an existing Resource Group."
  type        = string
  nullable    = false

  validation {
    condition     = can(coalesce(var.resource_group_name))
    error_message = "The 'resource_group_name' value is invalid. It must be a non-empty string."
  }
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
  nullable    = false
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false
}

variable "company_prefix" {
  description = "Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters."
  type        = string
  nullable    = true

  validation {
    condition     = var.company_prefix == null || try(length(trimspace(var.company_prefix)) > 0 && length(var.company_prefix) <= 5, false)
    error_message = format("Invalid value '%s' for variable 'company_prefix', it must be a non-empty string with a maximum of 5 characters.", coalesce(var.company_prefix, "null"))
  }
}

variable "override_name" {
  description = "Optional override for naming logic. If set, this value is used for the resource name."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.override_name == null || try(length(trimspace(var.override_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'override_name', it must be null or a non-empty string.", coalesce(var.override_name, "null"))
  }
}

variable "sku_name" {
  description = "The SKU name of the container registry. Possible values are 'Basic', 'Standard' and 'Premium'."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku_name'. Valid options are 'Basic', 'Standard', 'Premium'.", var.sku_name)
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for the container registry. Only applicable for Premium SKU."
  type        = bool
  default     = false
  nullable    = false
}

variable "trusted_services_bypass_firewall_enabled" {
  description = "Allow trusted Microsoft services to bypass this firewall. When enabled, trusted Microsoft services can access the Container Registry even when network access is restricted."
  type        = bool
  default     = true
  nullable    = false
}
