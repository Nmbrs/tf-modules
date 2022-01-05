variable "resource_group_name" {
  type = string
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
variable "address_space" {
  type= string
  description = "Address space for the vnet"
}

variable "subnet_prefixes" {
  type        = map(string) 
  description = "Subnet prefixes for the vnet"
}