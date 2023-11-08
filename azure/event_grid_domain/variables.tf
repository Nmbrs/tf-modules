variable "workload" {
  description = "The workload name of the event grid domain."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the name of the Resource Group where the resource should exist."
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

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this resource"
  type        = bool
}
