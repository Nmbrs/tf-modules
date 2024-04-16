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
  description = "The name of the SQL Server to connect to"
  type        = string

  validation {
    condition     = can(coalesce(var.workload))
    error_message = "The 'resource_group_name' value is invalid. It must be a non-empty string."
  }
}

variable "node_number" {
  description = "Specifies the node number for the resources."
  type        = number

  validation {
    condition     = alltrue([try(var.node_number > 0, false), try(var.node_number == floor(var.node_number), false)])
    error_message = format("Invalid value '%s' for variable 'node_number'. It must be an integer number and greater than 0.", var.node_number)
  }
}

variable "sql_admin" {
  description = "The name of the group that will be SQL Server admin"
  type        = string
}

variable "allowed_subnets" {
  description = "A map of subnets and their corresponding resource groups"
  type = list(object({
    subnet_resource_group_name = string
    virtual_network_name       = string
    subnet_name                = string
  }))
}

variable "storage_account_auditing" {
  description = "The name of the storage account to use for auditing"
  type        = string  
}

variable "storage_account_resource_group" {
  description = "The name of the resource group in which the storage account exists."
  type        = string  
}

variable "local_sql_admin" {
  description = "The name of the SQL Server admin to be used localy sql server"
  type        = string
  default     = ""
}

variable "local_sql_admin_password" {
  description = "The name of the secret in the key vault that contains the SQL Server admin password to be used localy sql server"
  type        = list(object({
    secret_name = string
    key_vault_id = string
  }))
  default = [ {
    key_vault_id = ""
    secret_name = ""
  } ]
}