variable "project" {
  type        = string
  description = "This variable defines the project name to be interpolated in multiple resources."
}
variable "environment" {
  type        = string
  description = "defines the environment to provision the resources."
}

variable "subnet_prefix_gateway" {
  type = string
  description = "Address prefix for the gateway subnet in the vnet"
}
variable "address_space" {
  type= string
  description = "Address space for the vnet"
}

variable "subnet_prefixes" {
  type        = map(string) 
  description = "Subnet prefixes for the vnet"
}