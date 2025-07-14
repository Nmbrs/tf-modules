variable "sku_name" {
  description = "The SKU name of the App Configuration. Possible values are 'free', 'standard', and 'premium'. Defaults to 'free'."
  type        = string
  default     = "free"
  validation {
    condition     = contains(["free", "standard", "premium"], lower(var.sku_name))
    error_message = "sku_name must be one of 'free', 'standard', or 'premium'."
  }
}

variable "resource_group_name" {
  description = "The name of an existing Resource Group."
  type        = string

  validation {
    condition     = can(coalesce(var.resource_group_name))
    error_message = "The resource group name must be a non-empty string."
  }
}

variable "workload" {
  description = "The workload name of the App Configuration."
  type        = string

  validation {
    condition     = can(coalesce(var.workload))
    error_message = "The workload value must be a non-empty string."
  }
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod", "stag", "sand"], var.environment)
    error_message = format("Invalid value '%s' for variable 'environment'. Valid options are 'dev', 'test', 'prod', 'stag', 'sand'.", var.environment)
  }
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exhaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string

  validation {
    condition     = can(coalesce(var.location))
    error_message = "The location must be a non-empty string."
  }
}

variable "override_name" {
  description = "Override the name of the App Configuration, to bypass naming convention."
  type        = string
  default     = null
  nullable    = true
}

variable "company_prefix" {
  description = "Prefix for the company name to be used in resource naming. Defaults to 'nmbrs'."
  type        = string
  default     = "nmbrs"

  validation {
    condition     = can(coalesce(var.company_prefix))
    error_message = "The company_prefix must be a non-empty string."
  }
}

