variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "node_number" {
  description = "Specifies the node number for the resources."
  type        = number

  validation {
    condition     = alltrue([try(var.node_number > 0, false), try(var.node_number == floor(var.node_number), false)])
    error_message = format("Invalid value '%s' for variable 'node_number'. It must be an integer number and greater than 0.", var.node_number)
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
  validation {
    condition     = contains(["app_service", "storage_account_blob", "storage_account_table", "storage_account_file", "sql_server", "key_vault", "service_bus", "eventgrid_domain", "eventgrid_topic", "container_registry"], var.resource_type)
    error_message = format("Invalid value '%s' for variable 'resource_type', valid options are 'app_service', 'storage_account_blob', 'storage_account_table', 'storage_account_file', 'sql_server', 'key_vault', 'service_bus', 'eventgrid_domain', 'eventgrid_topic', 'container_registry'.", var.resource_type)
  }
}

variable "workload" {
  description = "Name of the private endpoint"
  type        = string
}

variable "resource_group_name_private_dns_zone" {
  description = "Resource group where the private dns zone exists"
  type        = string
}

