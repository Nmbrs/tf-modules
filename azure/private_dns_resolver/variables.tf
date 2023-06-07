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
  type = list(object({
    subnet_name = string
  }))
  default = []

  validation {
    condition     = alltrue([for endpoint in var.inbound_endpoints : can(coalesce(endpoint.subnet_name))])
    error_message = "At least one 'subnet_name' property from 'inbound_endpoints' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for endpoint in var.inbound_endpoints : endpoint.subnet_name]) == length(distinct([for endpoint in var.inbound_endpoints : endpoint.subnet_name]))
    error_message = "At least one 'subnet_name' property from one of the 'inbound_endpoints' is duplicated. They must be unique."
  }
}

variable "outbound_endpoints" {
  description = "List of objects that represent the configuration of each outbound endpoint."
  type = list(object({
    subnet_name = string
  }))
  default = []

  validation {
    condition     = alltrue([for endpoint in var.outbound_endpoints : can(coalesce(endpoint.subnet_name))])
    error_message = "At least one 'subnet_name' property from 'outbound_endpoints' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for endpoint in var.outbound_endpoints : endpoint.subnet_name]) == length(distinct([for endpoint in var.outbound_endpoints : endpoint.subnet_name]))
    error_message = "At least one 'subnet_name' property from one of the 'outbound_endpoints' is duplicated. They must be unique."
  }
}