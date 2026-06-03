variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "workload" {
  description = "The workload name of the service bus namespace."
  type        = string
  nullable    = true

  validation {
    condition     = var.workload == null || try(length(trimspace(var.workload)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'workload', it must be null or a non-empty string.", coalesce(var.workload, "null"))
  }
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "override_name" {
  description = "Override the name of the service bus namespace, to bypass naming convention."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.override_name == null || try(length(trimspace(var.override_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'override_name', it must be null or a non-empty string.", coalesce(var.override_name, "null"))
  }
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

variable "sku_name" {
  description = "Configuration of the size and capacity of the service bus."
  type        = string

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku_name', valid options are 'Basic', 'Standard', 'Premium'.", var.sku_name)
  }
}

variable "capacity" {
  description = "The number of message units (resource isolation at the CPU and memory level so that each customer workload runs in isolation)."
  type        = number
  default     = 0

  validation {
    condition     = contains([0, 1, 2, 4, 8, 16], var.capacity)
    error_message = format("Invalid value '%s' for variable 'capacity', valid options are 0, 1, 2, 4, 8, 16.", var.capacity)
  }
}

variable "network_settings" {
  description = "Network settings for the service bus private endpoint."
  type = object({
    subnet_name              = string
    vnet_name                = string
    vnet_resource_group_name = string
  })
}

variable "private_dns_zone_ids" {
  description = "Resource IDs of the private DNS zones, keyed by subresource. Required keys: `namespace` (typically `privatelink.servicebus.windows.net`)."
  type = object({
    namespace = string
  })
}
