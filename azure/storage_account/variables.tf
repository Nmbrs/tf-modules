variable "project" {
  type        = string
  description = "nmbrs project name."
}

variable "environment" {
  type        = string
  description = "environment type of the apps"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group used for the storage account"
}

variable "kind" {
  # Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. 
  type        = string
  description = "Defines the Kind of storage account."
  default     = "StorageV2"
}

variable "account_tier" {
  # Valid options are Standard and Premium. 
  # For BlockBlobStorage and FileStorage accounts only Premium is valid.
  type        = string
  description = "Defines the Tier to use for this storage account."
  default     = "Standard"
}

variable "kind" {
  # Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. 
  type        = string
  description = "Defines the Kind of storage account."
  default     = "StorageV2"
}

variable "replication_type" {
  # Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS.
  type        = string
  description = "Defines the type of replication to use for this storage account."
  default     = "LRS"
}

variable "min_tls_version" {
  # Valid options are TLS1_0, TLS1_1, and TLS1_2. 
  type        = string
  description = "The minimum supported TLS version for the storage account."
  default     = "TLS1_2"
}

variable "enable_https_traffic_only" {
  type        = bool
  description = "Boolean flag which forces HTTPS if enabled"
  default     = true
}
