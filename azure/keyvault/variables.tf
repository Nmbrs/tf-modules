variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group"
}

variable "name" {
  type        = string
  description = "The name of the Azure Key Vault"
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

variable "writers" {
  type        = list(string)
  description = "Define a Azure Key Vault access policy"
}

variable "readers" {
  type        = list(string)
  description = "Define a Azure Key Vault access policy"
}
