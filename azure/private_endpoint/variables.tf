variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "virtual_network" {
  description = "value"
  type        = string
}

variable "resource_group_name_virtual_network" {
  description = "value"
  type        = string
}

variable "subnet_name" {
  description = "value"
  type        = string
}

variable "private_endpoint_name" {
  description = "value"
  type        = string
}

variable "resource_group_name" {
  description = "value"
  type        = string
}

variable "private_dns_zone_group" {
  description = "value"
  type        = string
}

variable "resource_group_name_private_dns_zone_group" {
  description = "value"
  type        = string
}


variable "resource_type" {
  description = "The type of resource (e.g., app_service, storage_account, database, virtual_machine)"
}

variable "resource_name" {
  description = "The name of the resource the private endpoint will connect to"
}

variable "resource_group_name_id" {
  description = "The name of the resource group of the service the private endpoint will connect to"
}