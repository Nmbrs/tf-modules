variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "name" {
  description = "Name of the  Redis instance. It must follow the CAF naming convention."
  type        = string

  validation {
    condition     = can(coalesce(var.name))
    error_message = "The 'name' value is invalid. It must be a non-empty string."
  }
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "shard_count" {
  description = "The number of shards for the Redis cluster."
  type        = number
  default     = 0
}

variable "cache_size_in_gb" {
  description = "The size of the Redis cache per instance in gigabytes (GB)"
  type        = number

  validation {
    condition     = contains([6, 13, 26, 53, 120], var.cache_size_in_gb)
    error_message = format("Invalid value '%s' for variable 'cache_size_in_gb', valid options are 6, 13, 26, 53, 120 (GB).", var.cache_size_in_gb)
  }
}
