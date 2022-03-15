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
  type = list(string)
  description = "Define a Azure Key Vault access policy"
}

variable "readers" {
  type = list(string)
  description = "Define a Azure Key Vault access policy"
}



###################################################################################################
# from this point forward we need to analyse which ones we need to expose to the user             #
# or stream the multiple variables in one or two that are clear for the user.                     #
###################################################################################################
variable "kv_secret_permissions_full" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

variable "kv_certificate_permissions_full" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers",
  "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update", "backup", "restore"]
}

variable "kv_secret_permissions_read" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["get", "list"]
}

variable "kv_certificate_permissions_read" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default     = ["get", "list"]
}

variable "kv_secret_permissions_write" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["get", "list", "set", "delete"]
}

variable "kv_certificate_permissions_write" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default     = ["get", "list", "update", "delete"]
}