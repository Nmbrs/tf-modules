variable "name" {
  description = "Name of the storage account."
  type        = string

  validation {
    condition     = can(coalesce(var.name))
    error_message = "The 'name' value is invalid. It must be a non-empty string."
  }

  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 24
    error_message = "The 'name' value is invalid. It must be between 3 and 24 characters."
  }

  validation {
    condition     = !can(regex("[^a-zA-Z0-9]+", var.name))
    error_message = "The 'name' value is invalid. It must only contain letters and numbers."
  }
}

variable "environment" {
  description = "(Optional) The environment in which the resource should be provisioned."
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  description = "The name of an existing Resource Group."
  type        = string

  validation {
    condition     = can(coalesce(var.resource_group_name))
    error_message = "The 'resource_group_name' value is invalid. It must be a non-empty string."
  }
}

variable "extra_tags" {
  description = "(Optional) A extra mapping of tags which should be assigned to the desired resource."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for tag in var.extra_tags : can(coalesce(var.extra_tags))])
    error_message = "At least on tag value from 'extra_tags' is invalid. They must be non-empty string values."
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
