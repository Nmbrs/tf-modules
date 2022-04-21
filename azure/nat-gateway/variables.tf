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


variable "vnet" {
  type        = list(any)
  description = "subnet to be added to the nat gw"
}