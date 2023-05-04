variable "name" {
  type        = string
  description = "This variable defines the name of the NAT gateway."
}

variable "natgw_resource_group" {
  type        = string
  description = "Resource group name for where the NAT gateway will be created"
}

variable "environment" {
  type        = string
  description = "Defines the environment to provision the resources."
}

variable "vnet_name" {
  type        = string
  description = "Name of the Vnet that will be added to the NAT gateway"
}

variable "vnet_resource_group" {
  type        = string
  description = "Resource group of the Vnet that will be added to the NAT gateway"
}

variable "subnets" {
  type        = list(any)
  description = "Subnets to be included in the NAT gateway"
}
