variable "workload" {
  description = "The workload name of the storage account."
  type        = string

  validation {
    condition     = length(var.workload) <= 13
    error_message = format("Invalid value '%s' for variable 'workload'. It must contain no more than 13 characters.", var.workload)
  }

  validation {
    condition     = !can(regex("[^a-zA-Z0-9]+", var.workload))
    error_message = format("Invalid value '%s' for variable 'workload'. It must only contain letters and numbers.", var.workload)
  }
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

variable "resource_group_name" {
  description = "The name of an existing Resource Group."
  type        = string

  validation {
    condition     = can(coalesce(var.resource_group_name))
    error_message = "The 'resource_group_name' value is invalid. It must be a non-empty string."
  }
}

variable "account_kind" {
  description = "Defines the Kind of storage account."
  type        = string

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "The 'account_kind value' is invalid. Valid options are 'BlobStorage', 'BlockBlobStorage', 'FileStorage', 'Storage' and 'StorageV2'."
  }
}

variable "sku_name" {
  description = "Defines the SKU name to use for this storage account."
  type        = string

  validation {
    condition     = contains(["Standard", "Premium"], var.sku_name)
    error_message = "The sku_name value is invalid. Valid options are 'Standard' and 'Premium'."
  }
}

variable "replication_type" {
  description = "Defines the type of replication to use for this storage account."
  type        = string

  validation {
    condition     = contains(["LRS", "GRS", "RAGS", "ZRS", "GZRS", "RAGZRS"], var.replication_type)
    error_message = "The replication_type value is invalid. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
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

variable "override_name" {
  description = "Optional override for naming logic. If set, this value is used for the resource name."
  type        = string
  default     = null
  nullable    = true
}

variable "public_network_access_enabled" {
  description = "A condition to indicate if the Storage Account will have public network access (defaults to false)."
  type        = bool
  default     = false
}

variable "trusted_services_bypass_firewall_enabled" {
  description = "Allow trusted Microsoft services to bypass this firewall. When enabled, trusted Microsoft services can access the Storage Account even when network access is restricted."
  type        = bool
  default     = true
}
