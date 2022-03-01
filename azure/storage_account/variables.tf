variable "name" {
  type        = string
  description = "Specifies the name of the the resource."
}

variable "location" {
  description = "Specifies the Azure Region where the resource should exists. Warning: Changing this forces a resource to be recreated."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resource."
  type        = string
}

variable "tags" {
  description = "List of mandatory resource tags."
  type        = map(string)
}

variable "account_kind" {
  description = "Defines the Kind of storage account."
  type        = string

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "The account_kind value is invalid. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  }
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account."
  type        = string

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "The account_tier value is invalid. Valid options are Standard and Premium."
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
