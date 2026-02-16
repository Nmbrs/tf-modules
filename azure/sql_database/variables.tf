
variable "workload" {
  description = "Short, descriptive name for the application, service, or workload. Used in resource naming conventions."
  type        = string
  nullable    = true

  validation {
    condition     = var.workload == null || try(length(trimspace(var.workload)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'workload', it must be null or a non-empty string.", coalesce(var.workload, "null"))
  }
}

variable "company_prefix" {
  description = "Short, unique prefix for the company or organization. Used in naming for uniqueness. Must be 1-5 characters."
  type        = string
  nullable    = true

  validation {
    condition     = var.company_prefix == null || try(length(trimspace(var.company_prefix)) > 0 && length(var.company_prefix) <= 5, false)
    error_message = format("Invalid value '%s' for variable 'company_prefix', it must be a non-empty string with a maximum of 5 characters.", coalesce(var.company_prefix, "null"))
  }
}

variable "override_name" {
  description = "Override the name of the SQL database, to bypass naming convention"
  type        = string
  default     = null
  nullable    = true
}

variable "location" {
  description = "The location where the SQL Server will be created"
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false
}

variable "sql_server_settings" {
  description = "SQL server settings."
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "elastic_pool_settings" {
  description = "SQL elastic pool settings. Optional - if not provided, database will use standalone SKU."
  type = object({
    name                = string
    resource_group_name = string
  })
  default  = null
  nullable = true
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
  default     = "S0"

  validation {
    condition     = contains(["S0", "S1", "S2", "S3", "S4", "GP_Gen5_2", "GP_Gen5_4", "GP_Gen5_6", "GP_Gen5_8", "GP_Gen5_10", "GP_Gen5_12", "GP_Gen5_14", "GP_Gen5_16", "GP_Gen5_18", "GP_Gen5_20"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku_name', valid options are 'S0', 'S1', 'S2', 'S3', 'S4', 'GP_Gen5_2', 'GP_Gen5_4', 'GP_Gen5_6', 'GP_Gen5_8', 'GP_Gen5_10', 'GP_Gen5_12', 'GP_Gen5_14', 'GP_Gen5_16', 'GP_Gen5_18', 'GP_Gen5_20'.", var.sku_name)
  }
}

variable "max_size_gb" {
  description = "The maximum size of the database in gigabytes, if it's inside an elastic pool this will be ignored and will use 1TB as max size."
  type        = number
  default     = 250
}

variable "sequence_number" {
  description = "A numeric value used to ensure uniqueness for resource names."
  type        = number
  nullable    = true

  validation {
    condition     = var.sequence_number == null || try(var.sequence_number >= 1 && var.sequence_number <= 999, false)
    error_message = format("Invalid value '%s' for variable 'sequence_number', it must be null or a number between 1 and 999.", coalesce(var.sequence_number, "null"))
  }
}
