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

variable "premium_messaging_partitions" {
  description = "Number of messaging partitions for a Premium namespace. Only honored when `sku_name = \"Premium\"` — must be 0 for Basic/Standard. Valid values: 0, 1, 2, 4. Changing this forces resource recreation."
  type        = number
  default     = 0

  validation {
    condition     = contains([0, 1, 2, 4], var.premium_messaging_partitions)
    error_message = format("Invalid value '%s' for variable 'premium_messaging_partitions', valid options are 0, 1, 2, 4.", var.premium_messaging_partitions)
  }
}

variable "firewall_settings" {
  description = "Firewall configuration: public access, trusted-service bypass, and allowed subnets for VNet rules. All fields are optional and default to a secure-by-default posture (no public access, no allowed subnets, trusted-service bypass enabled)."
  type = object({
    public_network_access_enabled            = optional(bool, false)
    trusted_services_bypass_firewall_enabled = optional(bool, true)
    allowed_subnet_ids                       = optional(list(string), [])
  })
  default = {}

  validation {
    condition     = var.firewall_settings.public_network_access_enabled || length(var.firewall_settings.allowed_subnet_ids) == 0
    error_message = "Invalid 'firewall_settings': 'allowed_subnet_ids' can only be specified when 'public_network_access_enabled' is true."
  }

  validation {
    condition     = alltrue([for id in var.firewall_settings.allowed_subnet_ids : length(trimspace(id)) > 0])
    error_message = "Invalid value in 'firewall_settings.allowed_subnet_ids': all subnet IDs must be non-empty strings."
  }

  validation {
    condition     = length(var.firewall_settings.allowed_subnet_ids) == length(distinct(var.firewall_settings.allowed_subnet_ids))
    error_message = "Invalid value in 'firewall_settings.allowed_subnet_ids': subnet IDs must be unique across all entries."
  }
}

variable "private_endpoint_settings" {
  description = "Settings for the private endpoint provisioned by this module. `subnet_id` is the resource ID of the subnet where the PEP NIC lands. `private_dns_zone_ids` maps each required subresource to its private DNS zone resource ID."
  type = object({
    subnet_id = string
    private_dns_zone_ids = object({
      namespace = string
    })
  })
}
