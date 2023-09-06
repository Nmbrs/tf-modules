variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "name" {
  type        = string
  description = "The name of the Azure Key Vault."
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "external_usage" {
  description = "(Optional) Specifies whether the keyvault should be used internally or externally."
  type        = bool
  default     = true
}

variable "protection_enabled" {
  description = "(Optional) Enables the keyvault purge protection in case of accidental deletion. Default is false."
  type        = bool
  default     = false
}

variable "policies" {
  description = "(Optional) Access policies created for the Azure Key Vault."
  type = list(object({
    name      = string
    object_id = string
    type      = string
  }))
  default = []

  validation {
    condition     = alltrue([for policy in var.policies : can(coalesce(policy.name))])
    error_message = "At least one 'name' property from 'policies' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for policy in var.policies : policy.name]) == length(distinct([for policy in var.policies : trimspace(lower(policy.name))]))
    error_message = "At least one 'name' property from one of the 'policies' is duplicated. They must be unique."
  }

  validation {
    condition     = alltrue([for policy in var.policies : can(regex("^[0-9a-fA-F]{8}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{12}$", policy.object_id))])
    error_message = "At least one 'object_id' property from 'policies' is invalid. They must valid UUIDs (32 characters, separated by four hyphens). Valid example: '11111111-1111-1111-1111-111111111111'."
  }

  validation {
    condition     = alltrue([for policy in var.policies : contains(["readers", "writers"], policy.type)])
    error_message = "At least one 'type' property from 'policies' is invalid. Valid options are 'readers', 'writers'."
  }
}
