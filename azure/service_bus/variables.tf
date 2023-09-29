variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "workload" {
  description = "The workload name of the service bus namespace."
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
  description = "Configuration of the size and capacity of the service bus."
  type        = string

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku_name', valid options are 'Basic', 'Standard', 'Premium'.", var.sku_name)
  }
}

variable "capacity" {
  description = "The number of message units (resource isolation at the CPU and memory level so that each customer workload runs in isolation)."
  type        = number
  default     = 0

  validation {
    condition     = contains([0, 1, 2, 4, 8, 16], var.capacity)
    error_message = format("Invalid value '%s' for variable 'capacity', valid options are 0, 1, 2, 4, 8, 16.", var.capacity)
  }
}

variable "zone_redundant" {
  description = "Defines whether or not this resource is zone redundant. The required sku to enable it needs to be 'Premium'."
  type        = bool
  default     = true
}

