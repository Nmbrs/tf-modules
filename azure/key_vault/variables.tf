variable "workload" {
  description = "The workload name of the key vault."
  type        = string

  validation {
    condition     = length(var.workload) <= 8
    error_message = format("Invalid value '%s' for variable 'workload'. It must contain no more than 8 characters.", var.workload)
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
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

variable "access_policies" {
  description = "(Optional) Access policies created for the Azure Key Vault."
  type = list(object({
    name      = string
    object_id = string
    type      = string
  }))
  default = []

  validation {
    condition     = alltrue([for policy in var.access_policies : can(coalesce(policy.name))])
    error_message = "At least one 'name' property from 'policies' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for policy in var.access_policies : policy.name]) == length(distinct([for policy in var.access_policies : trimspace(lower(policy.name))]))
    error_message = "At least one 'name' property from one of the 'policies' is duplicated. They must be unique."
  }

  validation {
    condition     = alltrue([for policy in var.access_policies : can(regex("^[0-9a-fA-F]{8}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{4}\\b-[0-9a-fA-F]{12}$", policy.object_id))])
    error_message = "At least one 'object_id' property from 'policies' is invalid. They must valid UUIDs (32 characters, separated by four hyphens). Valid example: '11111111-1111-1111-1111-111111111111'."
  }

  validation {
    condition     = alltrue([for policy in var.access_policies : contains(["readers", "writers", "administrators"], policy.type)])
    error_message = "At least one 'type' property from 'policies' is invalid. Valid options are 'readers', 'writers', 'administrators'."
  }
}

variable "rbac_authorization_enabled" {
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  type        = bool
}

variable "override_name" {
  description = "Override the name of the key vault, to bypass naming convention"
  type        = string
  default     = null
  nullable    = true
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

variable "public_network_access_enabled" {
  description = "A condition to indicate if the Key Vault will have public network access (defaults to false)."
  type        = bool
  default     = false
}

variable "trusted_services_bypass_firewall_enabled" {
  description = "Allow trusted Microsoft services to bypass this firewall. When enabled, trusted Microsoft services can access the Key Vault even when network access is restricted."
  type        = bool
  default     = true
}
