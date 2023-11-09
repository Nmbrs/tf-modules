variable "workload" {
  description = "The workload destined for the app gateway"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "instance_count" {
  description = "The number of the app gw in case you have more than one"
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "application_name" {
  description = "The values of the application that the application gateway will serve"
  type = list(object({
    name     = string
    fqdn     = string
    priority = number
    protocol = string
  }))

  default = []
}

variable "subnet_name" {
  description = "The name of the subnet used for the application gateway"
  type        = string
}

variable "vnet_name" {
  type        = string
  description = "Name of the VNET that will be added to the application gateway"
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Resource group of the VNET that will be added to the application gateway"
}

variable "key_vault_name" {
  description = "The name of the key vault used for the application gateway listener"
  type        = string
}

variable "key_vault_resource_group_name" {
  description = "The resource group where the key vault is located"
  type        = string
}

variable "key_vault_certificate_name" {
  description = "The name of the secret certificate in the key vault"
  type        = string
}

# variable "ssl_certificate_name" {
#   description = "Name to give to the certificate applied on the application gateway"
#   type        = string
# }

variable "certificate_display_name" {
  description = "Name to give to the certificate applied on the application gateway"
  type        = string
}

variable "managed_identity_name" {
  description = "The name of the managed identity used to access the key vault"
  type        = string
}

variable "managed_identity_resource_group_name" {
  description = "The resource group where the managed identity is located"
  type        = string
}

variable "min_capacity" {
  description = "Minimum value of instances the application gateway will have"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum value of instances the application gateway will have"
  type        = number
  default     = 10
}
