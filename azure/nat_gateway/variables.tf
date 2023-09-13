variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "name" {
  type        = string
  description = "This variable defines the name of the NAT gateway."
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  type        = string
  description = "Defines the environment to provision the resources."
}

variable "vnet_name" {
  type        = string
  description = "Name of the Vnet that will be added to the NAT gateway"
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Resource group of the Vnet that will be added to the NAT gateway"
}

variable "subnets" {
  type        = list(string)
  description = "Subnets to be included in the NAT gateway"
}

variable "name_sequence_number" {
  type        = number
  description = "A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance in the naming convention."

  validation {
    condition     = var.name_sequence_number >= 1 && var.name_sequence_number <= 999
    error_message = format("Invalid value '%s' for variable 'name'. It must be between 1 and 999.", var.name_sequence_number)
  }
}
