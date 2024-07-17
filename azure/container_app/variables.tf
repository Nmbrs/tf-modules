variable "workload" {
  description = "The name of the workload associated with the resource."
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "managed_identity_settings" {
  description = "A list of settings related to the app gateway managed identity used to retrieve SSL certificates."
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "workload_profile_name" {
  description = "The name of the workload profile to use."
  type        = string

  validation {
    condition     = contains(["Consumption", "Dedicated-D4", "Dedicated-D8", "Dedicated-16", "Dedicated-D32", "Dedicated-E4", "Dedicated-E8", "Dedicated-E16", "Dedicated-E32"], var.workload_profile_name)
    error_message = format("Invalid value '%s' for variable 'workload_profile_name', valid options are 'Consumption', 'Dedicated-D4', 'Dedicated-D8', 'Dedicated-16', 'Dedicated-D32', 'Dedicated-E4', 'Dedicated-E8', 'Dedicated-E16', 'Dedicated-E32'.", var.workload_profile_name)
  }
}

variable "container_app_environment_settings" {
  description = "A list of settings related to the container app environment."
  type = object({
    name                = string
    resource_group_name = string
  })
}
