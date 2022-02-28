variable "environment" {
  type        = string
  description = "Environment for the resource."
}

variable "project" {
  type        = string
  description = "Project name for the resource."
}

variable "location" {
  # For a complete list of available Azure regions run at cli:  
  # az account list-locations  --query "[].{displayName:displayName, location:name}" --output table
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name used for the storage account."
  type        = string
}

variable "tags" {
  description = "nmbrs list of mandatory resource tags."
  type        = map(string)
}

variable "kind" {
  # Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. 
  description = "Defines the Kind of storage account."
  type        = string
  default     = "StorageV2"
}

variable "account_tier" {
  # Valid options are Standard and Premium. 
  # For BlockBlobStorage and FileStorage accounts only Premium is valid.
  description = "Defines the Tier to use for this storage account."
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  # Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS.
  description = "Defines the type of replication to use for this storage account."
  type        = string
  default     = "LRS"
}

variable "min_tls_version" {
  # Valid options are TLS1_0, TLS1_1, and TLS1_2. 
  description = "The minimum supported TLS version for the storage account."
  type        = string
  default     = "TLS1_2"
}

variable "enable_https_traffic_only" {
  description = "Boolean flag which forces HTTPS if enabled."
  type        = bool
  default     = true
}
