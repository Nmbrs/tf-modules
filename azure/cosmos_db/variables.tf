variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "workload" {
  description = "(Required) Specifies the name of the resource."
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

variable "kind" {
  description = "defines the Kind of CosmosDB to create."
  type        = string

  validation {
    condition     = contains(["GlobalDocumentDB", "MongoDB", "Parse"], var.kind)
    error_message = format("Invalid value '%s' for variable 'kind', Valid options are 'GlobalDocumentDB', 'MongoDB', 'Parse'.", var.kind)
  }
}

variable "mongo_db_version" {
  description = "(Optional) The Server Version of a MongoDB account. Possible values are 4.2, 4.0, 3.6, and 3.2."
  type        = string
  default     = ""

  validation {
    condition     = contains(["4.2", "4.0", "3.6", "3.2", ""], var.mongo_db_version)
    error_message = format("Invalid value '%s' for variable 'mongo_db_version', Valid options are '4.2', '4.0', '3.6' and '3.2'.", var.mongo_db_version)
  }
}

variable "instance_count" {
  description = "A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance within the naming convention."
  type        = number

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 999
    error_message = format("Invalid value '%s' for variable 'instance_count'. It must be between 1 and 999.", var.instance_count)
  }
}

variable "public_network_access_enabled" {
  description = "A condition to indicate if the cosmos db will have public access (defaults to false)"
  type        = bool
  default     = false
}
