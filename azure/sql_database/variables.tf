variable "sql_server_resource_group_name" {
  description = "The name of the resource group in which the SQL server exists."
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

variable "sql_elastic_pool_name" {
  description = "The name of the elastic pool to add the database to"
  type        = string
  default     = ""
}

variable "workload" {
  description = "Name of the database to create"
  type        = string
  validation {
    condition     = var.workload != ""
    error_message = "Variable 'workload' cannot be empty."
  }
}

variable "override_name" {
  description = "Override the predefined naming of the database"
  type        = string  
}

variable "collation" {
  description = "The collation to use for the database"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" {
  description = "The license type to apply for this database"
  type        = string
  default     = "BasePrice"
  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = format("Invalid value '%s' for variable 'license_type', valid options are 'LicenseIncluded', 'BasePrice'.", var.license_type)
  }
}

variable "sku_name" {
  description = "The name of the SKU used by the database"
  type        = string
  default = ""

  # validation {
  #   condition     = contains(["S0", "S1", "S2", "S3", "S4", "S6", "S7", "GP_Gen5_2", "GP_Gen5_4", "GP_Gen5_6", "GP_Gen5_8", "GP_Gen5_10", "GP_Gen5_12", "GP_Gen5_14", "GP_Gen5_16", "GP_Gen5_18", "GP_Gen5_20"], var.sku_name)
  #   error_message = format("Invalid value '%s' for variable 'environment', valid options are 'S0', 'S1', 'S2', 'S3', 'S4', 'S6', 'S7', 'GP_Gen5_2', 'GP_Gen5_4', 'GP_Gen5_6', 'GP_Gen5_8', 'GP_Gen5_10', 'GP_Gen5_12', 'GP_Gen5_14', 'GP_Gen5_16', 'GP_Gen5_18', 'GP_Gen5_20'.", var.sku_name)
  # }
}

variable "max_size_gb" {
  description = "The maximum size of the database in gigabytes"
  type        = number
}