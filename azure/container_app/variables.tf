variable "workload" {
  description = "The name of the workload associated with the resource."
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "managed_identity_settings" {
  description = "A list of settings related to the app gateway managed identity used to retrieve SSL certificates."
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "container_app_environment_settings" {
  description = "A list of settings related to the container app environment."
  type = object({
    name                = string
    resource_group_name = string
  })
}