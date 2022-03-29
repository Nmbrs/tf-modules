variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "name" {
  type        = string
  description = "The name of the Azure Key Vault."
}

variable "external_usage" {
  description = "(Optional) Specifies whether the keyvault is for internal or external use."
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

variable "writers" {
  description = "Define an Azure Key Vault access policy."
  type = object({
    users        = list(string)
    applications = list(string)
    groups       = list(string)
  })
  default = {
    applications = []
    groups       = []
    users        = []
  }

}

variable "readers" {
  description = "Define an Azure Key Vault access policy."
  type = object({
    users        = list(string)
    applications = list(string)
    groups       = list(string)
  })
  default = {
    applications = []
    groups       = []
    users        = []
  }
}
