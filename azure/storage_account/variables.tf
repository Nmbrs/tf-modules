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
  description = "(Optional) The environment in which the resource should be provisioned."
  type        = string
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

variable "account_tier" {
  description = "Defines the Tier to use for this storage account."
  type        = string

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "The account_tier value is invalid. Valid options are 'Standard' and 'Premium'."
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
