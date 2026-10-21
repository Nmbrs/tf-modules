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
  description = "Short, descriptive name for the application, service, or workload. Used in resource naming conventions. Between 1 and 31 characters, letters, digits and hyphens only, so that the generated server name always fits the 63-character DNS label Azure requires."
  type        = string
  nullable    = true

  validation {
    condition     = var.workload == null || try(length(trimspace(var.workload)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'workload', it must be null or a non-empty string.", coalesce(var.workload, "null"))
  }

  validation {
    condition     = var.workload == null || try(length(var.workload) <= 31 && can(regex("^[A-Za-z0-9-]+$", var.workload)), false)
    error_message = format("Invalid value '%s' for variable 'workload', it must be between 1 and 31 characters and contain only letters, digits and hyphens.", coalesce(var.workload, "null"))
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
  description = "Optional numeric instance counter, zero-padded as `-NNN` suffix. Use only when provisioning multiple PostgreSQL servers for the same workload/env/region. Omit for the common single-instance case."
  type        = number
  default     = null
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
    condition     = length(trimspace(var.environment)) > 0
    error_message = format("Invalid value '%s' for variable 'environment', it must be a non-empty string.", var.environment)
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
  description = "The SKU of the PostgreSQL Flexible Server in the `{tier}_{size}` form Azure uses: `B_Standard_B1ms` (Burstable), `GP_Standard_D2s_v3` (General Purpose) or `MO_Standard_E2s_v3` (Memory Optimized). Burstable SKUs do not support high availability. Changing the SKU restarts the server."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^(B_Standard_B|GP_Standard_D|MO_Standard_E)", var.sku_name))
    error_message = format("Invalid value '%s' for variable 'sku_name', it must start with 'B_Standard_B', 'GP_Standard_D' or 'MO_Standard_E' (for example 'B_Standard_B1ms', 'GP_Standard_D2s_v3', 'MO_Standard_E2s_v3').", var.sku_name)
  }
}

variable "storage_mb" {
  description = "The storage size of the PostgreSQL Flexible Server in megabytes. Storage can only grow; auto-grow is always enabled."
  type        = number
  default     = 32768
  nullable    = false

  validation {
    condition     = contains([32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4193280, 4194304, 8388608, 16777216, 33553408], var.storage_mb)
    error_message = format("Invalid value '%s' for variable 'storage_mb', valid options are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4193280, 4194304, 8388608, 16777216, 33553408 (MB).", var.storage_mb)
  }
}

variable "postgresql_version" {
  description = "The major version of PostgreSQL to run on the server."
  type        = string
  default     = "16"
  nullable    = false

  validation {
    condition     = contains(["12", "13", "14", "15", "16"], var.postgresql_version)
    error_message = format("Invalid value '%s' for variable 'postgresql_version', valid options are '12', '13', '14', '15', '16'.", var.postgresql_version)
  }
}

variable "zone" {
  description = "The availability zone in which the server is provisioned ('1', '2' or '3'). When null, Azure picks one. The zone is ignored after creation because Azure swaps the primary and standby zones on failover."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.zone == null || try(contains(["1", "2", "3"], var.zone), false)
    error_message = format("Invalid value '%s' for variable 'zone', it must be null, '1', '2' or '3'.", coalesce(var.zone, "null"))
  }
}

variable "high_availability_mode" {
  description = "High availability mode of the server: null (disabled), 'SameZone' or 'ZoneRedundant'. Not supported by Burstable SKUs."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.high_availability_mode == null || try(contains(["SameZone", "ZoneRedundant"], var.high_availability_mode), false)
    error_message = format("Invalid value '%s' for variable 'high_availability_mode', it must be null, 'SameZone' or 'ZoneRedundant'.", coalesce(var.high_availability_mode, "null"))
  }
}

variable "backup_settings" {
  description = "Backup configuration: `retention_days` (7 to 35) and `geo_redundant_enabled`. Geo-redundancy can only be chosen at creation; changing it afterwards replaces the server."
  type = object({
    retention_days        = optional(number, 7)
    geo_redundant_enabled = optional(bool, false)
  })
  default  = {}
  nullable = false

  validation {
    condition     = var.backup_settings.retention_days >= 7 && var.backup_settings.retention_days <= 35
    error_message = format("Invalid value '%s' for 'backup_settings.retention_days', it must be a number between 7 and 35.", var.backup_settings.retention_days)
  }
}

variable "admin_settings" {
  description = "Administrative access for the PostgreSQL Flexible Server: the Entra ID group set as server administrator, whether Entra ID is the only authentication method (default), and the local administrator login used when password authentication is enabled. In Entra-only mode no local administrator and no password exist. When password authentication is enabled, the local administrator password is generated by the module at creation and is never stored or surfaced; it is expected to be reset out-of-band and Terraform ignores later changes to it."
  type = object({
    azuread_group_name                  = string
    azuread_authentication_only_enabled = optional(bool, true)
    local_username                      = string
  })
  nullable = false

  validation {
    condition     = length(trimspace(var.admin_settings.azuread_group_name)) > 0
    error_message = "Invalid value for 'admin_settings.azuread_group_name'. It must be a non-empty string."
  }

  validation {
    condition     = length(trimspace(var.admin_settings.local_username)) > 0
    error_message = "Invalid value for 'admin_settings.local_username'. It must be a non-empty string."
  }

  validation {
    condition = (
      !contains(["azure_superuser", "azure_pg_admin", "admin", "administrator", "root", "guest", "public"], lower(trimspace(var.admin_settings.local_username)))
      && !startswith(lower(trimspace(var.admin_settings.local_username)), "pg_")
    )
    error_message = "Invalid value for 'admin_settings.local_username'. Azure rejects reserved PostgreSQL login names: azure_superuser, azure_pg_admin, admin, administrator, root, guest, public, and any name starting with 'pg_'."
  }
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this PostgreSQL Flexible Server."
  type        = bool
  default     = false
  nullable    = false
}

variable "private_endpoint_settings" {
  description = "Settings for the private endpoint provisioned by this module. `subnet_id` is the resource ID of the subnet where the PEP NIC lands. `private_dns_zone_ids` maps each required subresource to its private DNS zone resource ID."
  type = object({
    subnet_id = string
    private_dns_zone_ids = object({
      postgresqlServer = string
    })
  })
  nullable = false

  validation {
    condition     = length(trimspace(var.private_endpoint_settings.subnet_id)) > 0
    error_message = "Invalid value for 'private_endpoint_settings.subnet_id'. It must be a non-empty string."
  }

  validation {
    condition     = length(trimspace(var.private_endpoint_settings.private_dns_zone_ids.postgresqlServer)) > 0
    error_message = "Invalid value for 'private_endpoint_settings.private_dns_zone_ids.postgresqlServer'. It must be a non-empty string."
  }
}
