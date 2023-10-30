variable "name" {
  description = "Specifies the name which should be used for this Private DNS Resolver."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Specifies the name of the Resource Group where the Private DNS Resolver should exist."
}

variable "vnet_name" {
  type        = string
  description = "Specifies the name of the VNET associated with the Private DNS Resolver."
}
variable "vnet_resource_group_name" {
  type        = string
  description = "Specifies the name of the VNET name associated with the Private DNS Resolver."
}

variable "inbound_endpoints" {
  description = "List of objects that represent the configuration of each inbound endpoint."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for endpoint in var.inbound_endpoints : can(coalesce(endpoint))])
    error_message = "At least one element from the 'inbound_endpoints' list is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length(var.inbound_endpoints) == length(distinct(var.inbound_endpoints))
    error_message = "At least one element from the 'inbound_endpoints' list is duplicated. They must be unique."
  }
}

variable "outbound_endpoints" {
  description = "List of objects that represent the configuration of each outbound endpoint."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for endpoint in var.outbound_endpoints : can(coalesce(endpoint))])
    error_message = "At least one element from 'outbound_endpoints' list is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length(var.outbound_endpoints) == length(distinct(var.outbound_endpoints))
    error_message = "At least one element from the 'outbound_endpoints' list is duplicated. They must be unique."
  }
}

variable "name_sequence_number" {
  type        = number
  description = "A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance in the naming convention."

  validation {
    condition     = var.name_sequence_number >= 1 && var.name_sequence_number <= 999
    error_message = format("Invalid value '%s' for variable 'name'. It must be between 1 and 999.", var.name_sequence_number)
  }
}
