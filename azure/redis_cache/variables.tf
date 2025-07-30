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
    error_message = format("Invalid value '%s' for variable 'environment', valid options are 'dev', 'test', 'prod', 'sand', 'stag'.", var.environment)
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

variable "sku_name" {
  description = "Configuration of the size and capacity of the Redis cache."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku_name', valid options are 'Basic', 'Standard', 'Premium'.", var.sku_name)
  }
}

variable "cache_size_in_gb" {
  description = "The size of the Redis cache per instance in gigabytes (GB)."
  type        = number
  nullable    = false

  validation {
    condition     = contains([0.25, 1, 2.5, 6, 13, 26, 53, 120], var.cache_size_in_gb)
    error_message = format("Invalid value '%s' for variable 'cache_size_in_gb', valid options are 0.25, 1, 2.5, 6, 13, 26, 53, 120 (GB).", var.cache_size_in_gb)
  }
}

variable "shard_count" {
  description = "The number of shards for the Redis cluster. Only required when using a Premium SKU."
  type        = number
  default     = 0
  nullable    = true

  validation {
    condition     = var.shard_count == null || try(var.shard_count >= 0 && var.shard_count <= 10, false)
    error_message = format("Invalid value '%s' for variable 'shard_count', it must be null or between 0 and 10.", coalesce(var.shard_count, "null"))
  }
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this Redis instance."
  type        = bool
  default     = false
  nullable    = false
}
