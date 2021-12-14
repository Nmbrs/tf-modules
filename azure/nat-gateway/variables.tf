variable "project" {
  type        = string
  description = "This variable defines the project name to be interpolated in multiple resources."
}

variable "natgw_resource_group" {
  type        = string
  description = "nat gateway resource group name"
}

variable "environment" {
  type        = string
  description = "defines the environment to provision the resources."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "defines the vnet resource group."

}

variable "vnet_virtual_network_name" {
  type        = string
  description = "defines the azure vnet virtual network."

}

variable "subnet_name" {
  type        = string
  description = "defines azure subnet name."
}