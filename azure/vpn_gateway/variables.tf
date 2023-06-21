variable "name" {
  type        = string
  description = "This variable defines the name of the NAT gateway."
}

variable "vg_resource_group" {
  type        = string
  description = "Resource group name for where the virtual gateway will be created"
}

variable "environment" {
  type        = string
  description = "Defines the environment to provision the resources."
}

variable "vnet_name" {
  type        = string
  description = "Name of the Vnet that will be added to the virtual gateway"
}

variable "vnet_resource_group" {
  type        = string
  description = "Resource group of the Vnet that will be added to the virtual gateway"
}

variable "address_space" {
  type        = list(any)
  description = "Address space of the VPN for the connecting clients"
}

variable "aad_audience" {
  type        = string
  description = "The client id of the Azure VPN application."
}

variable "aad_issuer" {
  type        = string
  description = "The STS url for your tenant"
}

variable "aad_tenant" {
  type        = string
  description = "AzureAD Tenant URL"
}
