variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
  default     = "westeurope"
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  default     = "prod"
}

variable "instance_count" {
  type        = number
  description = "A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance in the naming convention."

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 999
    error_message = format("Invalid value '%s' for variable 'instance_count'. It must be between 1 and 999.", var.instance_count)
  }
}

variable "resource_group_name_virtual_network" {
  description = "Resource group of the virtual network where the private endpoint will connect to"
  type        = string
}

variable "virtual_network" {
  description = "Name of the vnet the private endpoint will connect to"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet that the private endpoint will connect to"
  type        = string
}

variable "resource_group_name" {
  description = "value"
  type        = string
}

variable "resource_name" {
  description = "The name of the resource the private endpoint will connect to"
}

variable "resource_type" {
  description = "The type of resource (e.g., app_service, storage_account, database, key_vault)"
}

variable "private_endpoint_name" {
  description = "Name of the private endpoint"
  type        = string
}

variable "resource_group_name_private_dns_zone_group" {
  description = "Resource group where the private dns zone exists"
  type        = string
}

