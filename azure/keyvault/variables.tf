variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group"
}

variable "location" {
  description = "Azure resource region."
  type        = string
}

variable "name" {
  type        = string
  description = "The name of the Azure Key Vault"

  validation {
    condition     = length(var.name) <= 24
    error_message = "The key vault name max lenght is 24."
  }
}

variable "tags" {
  type        = any
  description = "List of azure tag resources."
}

variable "writers" {
  type        = list(string)
  description = "Define a Azure Key Vault access policy"
}

variable "readers" {
  type        = list(string)
  description = "Define a Azure Key Vault access policy"
}

variable "isProtect" {
  type        = bool
  description = "Protects from accidental deletion by enabling keyvault purge setting."
}
