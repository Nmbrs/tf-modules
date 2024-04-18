variable "resource_group_name" {
  description = "The name of the resource group to create the SQL Server in"
  type        = string
}

variable "location" {
  description = "The location where the SQL Server will be created"
  type        = string
}

variable "environment" {
  description = "Defines the environment to provision the resources."
  type        = string

  validation {
    condition     = contains(["dev", "test", "sand", "prod"], var.environment)
    error_message = format("Invalid value '%s' for variable 'environment', valid options are 'dev', 'test', 'sand', 'global'.", var.environment)
  }
}

variable "country" {
  description = "Specifies the country for the app services and service plan names."
  type        = string

  validation {
    condition     = contains(["se", "nl", "global"], var.country)
    error_message = format("Invalid value '%s' for variable 'country', valid options are 'se', 'nl', 'global'.", var.country)
  }
}

variable "workload" {
  description = "The name of the SQL Server that will be created"
  type        = string

  validation {
    condition     = can(coalesce(var.workload))
    error_message = "The 'workload' value is invalid. It must be a non-empty string."
  }
}

variable "override_name" {
  description = "Overrides the name of the SQL Server that will be created"
  type        = string
  default     = ""
}

variable "node_number" {
  description = "Specifies the node number for the resources."
  type        = number

  validation {
    condition     = alltrue([try(var.node_number > 0, false), try(var.node_number == floor(var.node_number), false)])
    error_message = format("Invalid value '%s' for variable 'node_number'. It must be an integer number and greater than 0.", var.node_number)
  }
}

variable "azuread_sql_admin" {
  description = "The name of the admin (Azure AD group) that will be SQL Server admin"
  type        = string
}

variable "allowed_subnets" {
  description = "A map of subnets and their corresponding resource groups that will be allowed to connect to the server."
  type = list(object({
    subnet_resource_group_name = string
    virtual_network_name       = string
    subnet_name                = string
  }))
}

variable "azuread_authentication_only_enabled" {
  description = "Specifies if only Azure AD authentication is allowed"
  type        = bool
  default     = true
}

variable "storage_account_auditing_settings" {
  description = "The settings necessary for the storage account auditing, the name and the resource group."
  type = object({
    storage_account_name           = string
    storage_account_resource_group = string
  })
}

variable "local_sql_admin_settings" {
  description = "The settings necessary for the local SQL admin creation, the username and the key vault settings for the password."
  type = object({
    local_sql_admin          = string
    key_vault_name           = string
    key_vault_resource_group = string
    key_vault_secret_name    = string
  })
}
