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
  description = "Subnets configuration"
  type = list(object({
    name                                           = string
    address_prefixes                               = list(string)
    enforce_private_link_endpoint_network_policies = bool
    enforce_private_link_service_network_policies  = bool
  }))
}

variable "tags" {
  description = "Associated tags"
  default     = {}
}

variable "location" {
  description = "Geographic location"
  type        = string
}

