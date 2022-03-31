variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "name" {
  type        = string
  description = "The name of the Azure Key Vault."
}

variable "external_usage" {
  description = "(Optional) Specifies whether the keyvault should be used internally or externally."
  type        = bool
  default     = true
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
    condition     = alltrue([for policy in var.policies : can(coalesce(policy.object_id))])
    error_message = "At least one 'object_id' property from 'policies' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = alltrue([for policy in var.policies : contains(["readers", "writers"], policy.type)])
    error_message = "At least one 'type' property from 'policies' is invalid. Valid options are 'readers', 'writers'."
  }
}
