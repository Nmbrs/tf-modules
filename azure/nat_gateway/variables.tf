variable "name" {
  type        = string
  description = "This variable defines the name of the NAT gateway."
}

variable "natgw_resource_group" {
  type        = string
  description = "NAT gateway resource group name"
}

variable "environment" {
  type        = string
  description = "Defines the environment to provision the resources."
}


variable "vnet" {
  type = map(object({
    name                 = string
    virtual_network_name = string
    resource_group_name  = string
    })
  )
  description = "Subnet to be added to the NAT gateway"
}
