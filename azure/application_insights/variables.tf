variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "name" {
  description = "The workload name of the app insights component."
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
  description = "Specifies the retention period in days."
  type        = number
  default     = 90

  validation {
    condition     = contains([30, 60, 90, 120, 180, 270, 550, 730], var.retention_in_days)
    error_message = format("Invalid value '%s' for variable 'retention_in_days'. valid options are 30, 60, 90, 120, 180, 270, 550, 730.", var.retention_in_days)
  }
}

variable "application_type" {
  description = "Specifies the retention period in days."
  type        = string

  validation {
    condition     = contains(["ios", "java", "MobileCenter", "NoNode.JS", "other", "phone", "store", "web"], var.application_type)
    error_message = format("Invalid value '%s' for variable 'application_type'. valid options are 'ios', 'java', 'MobileCenter', 'NoNode.JS', 'other', 'phone', 'store', 'web'.", var.application_type)
  }
}

variable "workspace_name" {
  type        = string
  description = "Name of the log analytics workspace that will be added to the NAT gateway"
}

variable "workspace_resource_group_name" {
  type        = string
  description = "Resource group of the log analytics workspace that will be added to the NAT gateway"
}
