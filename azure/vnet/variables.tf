variable "resource_group_name" {
  type        = string
  description = "Resource Group used for the vnet"
}

variable "project" {
  type        = string
  description = "This variable defines the project name to be interpolated in multiple resources."
}

variable "environment" {
  type        = string
  description = "defines the environment to provision the resources."
}

variable "virtual_networks" {
  description = "The virtal networks with their properties."
  type        = any
}

variable "subnets" {
  description = "The virtal networks subnets with their properties."
  type        = any
}
