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

variable "sql_server_name" {
  description = "The name of the SQL Server to connect to"
  type        = string
  validation {
    condition     = var.sql_server_name != ""
    error_message = "Variable 'sql_server_name' cannot be empty."
  }
}

variable "sql_admin" {
  description = "The name of the group that will be SQL Server admin"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network in which the subnet to be added to SQL firewall rules exists"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet to add to the SQL Server firewall rule"
  type        = string
}

variable "subnet_resource_group_name" {
  description = "The name of the resource group in which the subnet exists"
  type        = string
}