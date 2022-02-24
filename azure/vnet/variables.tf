variable "resource_group_name" {
  description = "Resource Group name used for the vnet"
  type        = string
}

variable "project" {
  description = "This variable defines the project name to be interpolated in multiple resources."
  type        = string
}

variable "environment" {
  description = "defines the environment to provision the resources."
  type        = string
}

variable "virtual_networks" {
  description = "The virtal networks with their properties."
  type        = any
}

variable "subnets" {
  description = "The virtal networks subnets with their properties."
  type        = any
}

variable "vnets_to_peer" {
  description = "List of vnet to peer with."
  default     = {}
  type        = any
}
