variable "workload" {
  description = "The workload name of the private endpoint."
  type        = string
}

variable "resource_group_name" {
  description = "The name of an existing Resource Group."
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


variable "instance_count" {
  type        = number
  description = "A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance in the naming convention."

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 999
    error_message = format("Invalid value '%s' for variable 'instance_count'. It must be between 1 and 999.", var.instance_count)
  }
}

variable "network_settings" {
  description = "Defines the network settings for the resources, specifying the subnet, virtual network name, and the resource group for the virtual network."
  type = object(
    {
      subnet_name              = string
      vnet_name                = string
      vnet_resource_group_name = string
    }
  )
}

variable "resource_settings" {
  description = "Defines the settings for the associated resources, specifying the name, and the resource group for it."
  type = object(
    {
      name                = string
      type                = string
      resource_group_name = string
    }
  )
  validation {
    condition     = contains(["app_service", "storage_account_blob", "storage_account_table", "storage_account_file", "sql_server", "key_vault", "service_bus", "eventgrid_domain", "eventgrid_topic", "container_registry", "cosmos_db_nosql","cosmos_db_mongodb"], var.resource_settings.type)
    error_message = format("Invalid value '%s' for variable 'resource_settings.type'. Valid options are 'app_service', 'storage_account_blob', 'storage_account_table', 'storage_account_file', 'sql_server', 'key_vault', 'service_bus', 'eventgrid_domain', 'eventgrid_topic', 'container_registry'.", var.resource_settings.type)
  }
}

variable "private_dns_zone_settings" {
  description = "Defines the private dns zone settings."
  type = object(
    {
      name                = string
      resource_group_name = string
    }
  )
}