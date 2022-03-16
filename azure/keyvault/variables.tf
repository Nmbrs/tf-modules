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



###################################################################################################
# from this point forward we need to analyse which ones we need to expose to the user             #
# or stream the multiple variables in one or two that are clear for the user.                     #
###################################################################################################
variable "kv_secret_permissions_full" {
  type        = list(string)
  description = "List of full permissions for secrets."
  validation {
    condition     = alltrue([for permission in var.kv_secret_permissions_full : contains(["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"], permission)])
    error_message = "At least one of the elements in the kv_secret_permissions_full list is invalid. Valid options are Backup, Delete, Get, List, Purge, Recover, Restore, Set."
  }
  default = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
}

variable "kv_certificate_permissions_full" {
  type        = list(string)
  description = "List of full permissions for certificates."
  validation {
    condition     = alltrue([for permission in var.kv_certificate_permissions_full : contains(["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"], permission)])
    error_message = "At least one of the elements in the kv_certificate_permissions_full list is invalid. Valid options are Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers, Update."
  }
  default = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
}

variable "kv_secret_permissions_read" {
  type        = list(string)
  description = "List of reading permissions for secrets."
  validation {
    condition     = alltrue([for permission in var.kv_secret_permissions_read : contains(["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"], permission)])
    error_message = "At least one of the elements in the kv_secret_permissions_read list is invalid. Valid options are Backup, Delete, Get, List, Purge, Recover, Restore, Set."
  }
  default = ["Get", "List"]
}

variable "kv_certificate_permissions_read" {
  type        = list(string)
  description = "List of reading permissions for certificates."
  validation {
    condition     = alltrue([for permission in var.kv_certificate_permissions_read : contains(["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"], permission)])
    error_message = "At least one of the elements in the kv_certificate_permissions_read list is invalid. Valid options are Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers, Update."
  }
  default = ["Get", "List"]
}

variable "kv_secret_permissions_write" {
  type        = list(string)
  description = "List of writing permissions for secrets."
  validation {
    condition     = alltrue([for permission in var.kv_secret_permissions_write : contains(["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"], permission)])
    error_message = "At least one of the elements in the kv_secret_permissions_write list is invalid. Valid options are Backup, Delete, Get, List, Purge, Recover, Restore, Set."
  }
  default = ["Get", "List", "Set"]
}

variable "kv_certificate_permissions_write" {
  type        = list(string)
  description = "List of writing permissions for certificates."
  validation {
    condition     = alltrue([for permission in var.kv_certificate_permissions_write : contains(["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"], permission)])
    error_message = "At least one of the elements in the kv_certificate_permissions_write list is invalid. Valid options are Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers, Update."
  }
  default = ["Get", "List", "Update"]
}
