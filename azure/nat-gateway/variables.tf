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
  type = string
  description = "subnet to be added to the nat gw"
}

# variable "vnet" {
#   type        = object({
#     resource_group_name   = string
#     virtual_network_name  = string
#     subnet_name           = string
#   })
#   description = "azure vnet structure data"
# }