variable "resource_group_name" {
  description = "Resource group name for where the virtual gateway will be created"
  type        = string

}

variable "workload" {
  description = "The workload name of the virtual gateway."
  type        = string

}

variable "environment" {
  description = "Defines the environment to provision the resources."
  type        = string

}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Vnet that will be added to the virtual gateway"
  type        = string

}

variable "vnet_resource_group_name" {
  description = "Resource group of the Vnet that will be added to the virtual gateway"
  type        = string
}

variable "address_spaces" {
  description = "The address space out of which IP addresses for vpn clients will be taken. You can provide more than one address space, e.g. in CIDR notation"
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for address_space in var.address_spaces : can(cidrhost(address_space, 0))])
    error_message = "At least one of the values from 'address_spaces' property is invalid. They must be valid CIDR blocks."
  }
}

variable "sku_name" {
  description = "Configuration of the size and capacity of the virtual network gateway."
  type        = string
  default     = "VpnGw1"

  validation {
    condition     = contains(["Basic", "Standard", "HighPerformance", "UltraPerformance", "ErGw1AZ", "ErGw2AZ", "ErGw3AZ", "VpnGw1", "VpnGw2", "VpnGw3", "VpnGw4", "VpnGw5", "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ", "VpnGw4AZ", "VpnGw5AZ"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku_name', valid options are 'Basic', 'Standard', 'HighPerformance', 'UltraPerformance', 'ErGw1AZ', 'ErGw2AZ', 'ErGw3AZ', 'VpnGw1', 'VpnGw2', 'VpnGw3', 'VpnGw4', 'VpnGw5', 'VpnGw1AZ', 'VpnGw2AZ', 'VpnGw3AZ', 'VpnGw4AZ', 'VpnGw5AZ'.", var.sku_name)
  }
}

variable "generation" {
  description = "The Generation of the Virtual Network gateway."
  type        = string
  default     = "Generation1"
  validation {
    condition     = contains(["Generation1", "Generation2", "None"], var.generation)
    error_message = format("Invalid value '%s' for variable 'generation', valid options are 'Generation1', 'Generation2', 'None'.", var.generation)
  }
}

variable "naming_count" {
  description = "A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance within the naming convention."
  type        = number

  validation {
    condition     = var.naming_count >= 1 && var.naming_count <= 999
    error_message = format("Invalid value '%s' for variable 'naming_count'. It must be between 1 and 999.", var.naming_count)
  }
}
