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
  description = "Specifies the name of the Resource Group where the Private DNS Resolver should exist."
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

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this resource"
  type        = bool
}

variable "topics" {
  description = "List of event grid domain topics."
  type        = list(string)
}
