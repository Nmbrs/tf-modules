variable "override_name" {
  description = "Override the name of the Application Insights component. If not provided, the name will be generated based on the naming convention."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.override_name == null || try(length(trimspace(var.override_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'override_name', it must be null or a non-empty string.", coalesce(var.override_name, "null"))
  }
}

variable "workload" {
  description = "The workload name of the Application Insights component."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.workload == null || try(length(trimspace(var.workload)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'workload', it must be null or a non-empty string.", coalesce(var.workload, "null"))
  }
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exhaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "Invalid value for variable 'location', it must be a non-empty string."
  }
}

variable "resource_group_name" {
  description = "The name of an existing Resource Group."
  type        = string
  nullable    = false
}

variable "workspace_settings" {
  description = "Settings for the Log Analytics Workspace to associate with Application Insights."
  type = object({
    name                = string
    resource_group_name = string
  })
  nullable = false
}

variable "application_type" {
  description = "Specifies the type of Application Insights to create. Valid options are 'ios', 'java', 'MobileCenter', 'Node.JS', 'other', 'phone', 'store', 'web'."
  type        = string

  validation {
    condition     = contains(["ios", "java", "MobileCenter", "Node.JS", "other", "phone", "store", "web"], var.application_type)
    error_message = format("Invalid value '%s' for variable 'application_type'. Valid options are 'ios', 'java', 'MobileCenter', 'Node.JS', 'other', 'phone', 'store', 'web'.", var.application_type)
  }
}

variable "retention_in_days" {
  description = "Specifies the retention period in days. Valid values are 30, 60, 90, 120, 180, 270, 365, 550, 730."
  type        = number
  default     = 90

  validation {
    condition     = contains([30, 60, 90, 120, 180, 270, 365, 550, 730], var.retention_in_days)
    error_message = format("Invalid value '%s' for variable 'retention_in_days'. Valid options are 30, 60, 90, 120, 180, 270, 365, 550, 730.", var.retention_in_days)
  }
}
