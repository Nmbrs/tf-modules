variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "workload" {
  description = "The workload name of the log analytics workspace."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "sku_name" {
  description = "Configuration of the size and capacity of the logspace analytics."
  type        = string

  validation {
    condition     = contains(["Free", "PerNode", "Premium", "Standard", "Standalone", "Unlimited", "CapacityReservation", "PerGB2018"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku_name', valid options are 'Free', 'PerNode', 'Premium', 'Standard', 'Standalone', 'Unlimited', 'CapacityReservation','PerGB2018'.", var.sku_name)
  }
}

variable "retention_in_days" {
  description = "The workspace data retention in days."
  type        = number
  default     = 90

  validation {
    condition     = alltrue([try(var.retention_in_days >= 30, false), try(var.retention_in_days <= 730, false)])
    error_message = format("Invalid value '%s' for variable 'retention_in_days'. It must be an integer number and range between 30 and 730.", var.retention_in_days)
  }
}
