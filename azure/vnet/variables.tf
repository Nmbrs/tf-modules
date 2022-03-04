variable "resource_group_name" {
  description = "Resource Group name used for the vnet"
  type        = string
}

variable "vnet_name" {
  description = "VNET name"
  type        = string
}

variable "address_space" {
  description = "VNET address space"
  type        = list(string)
}

variable "subnets" {
  type        = any
  default     = []
  description = "List of objects that represent the configuration of each subnet."
}

variable "tags" {
  description = "Associated tags"
  default     = {}
}

variable "location" {
  description = "Geographic location"
  type        = string
}

