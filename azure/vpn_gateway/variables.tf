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

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false
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

variable "resource_group_name" {
  description = "Specifies the name of the resource group where the resource should be provisioned."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = format("Invalid value '%s' for variable 'resource_group_name', it must be a non-empty string.", var.resource_group_name)
  }
}

variable "network_settings" {
  description = "Settings related to the network connectivity of the VPN gateway."
  type = object({
    vnet_name                = string
    vnet_resource_group_name = string
    address_spaces           = optional(list(string), [])
  })

  nullable = false

  validation {
    condition     = try(length(trimspace(var.network_settings.vnet_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'network_settings.vnet_name', it must be a non-empty string.", coalesce(var.network_settings.vnet_name, "null"))
  }

  validation {
    condition     = try(length(trimspace(var.network_settings.vnet_resource_group_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'network_settings.vnet_resource_group_name', it must be a non-empty string.", coalesce(var.network_settings.vnet_resource_group_name, "null"))
  }

  validation {
    condition     = alltrue([for address_space in var.network_settings.address_spaces : can(cidrhost(address_space, 0))])
    error_message = "At least one of the values from 'network_settings.address_spaces' property is invalid. They must be valid CIDR blocks."
  }
}

variable "sku_name" {
  description = "Configuration of the size and capacity of the virtual network gateway."
  type        = string
  default     = "VpnGw1"

  validation {
    condition     = contains(["Basic", "Standard", "HighPerformance", "UltraPerformance", "ErGw1AZ", "ErGw2AZ", "ErGw3AZ", "VpnGw1", "VpnGw2", "VpnGw3", "VpnGw4", "VpnGw5", "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ", "VpnGw4AZ", "VpnGw5AZ"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku_name', valid options are 'Basic', 'Standard', 'HighPerformance', 'UltraPerformance', 'ErGw1AZ', 'ErGw2AZ', 'ErGw3AZ', 'VpnGw1', 'VpnGw2', 'VpnGw3', 'VpnGw4', 'VpnGw5', 'VpnGw1AZ', 'VpnGw2AZ', 'VpnGw3AZ', 'VpnGw4AZ', 'VpnGw5AZ'.", var.sku_name)
  }
}
