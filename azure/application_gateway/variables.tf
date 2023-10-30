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
  type = map(object({
    name     = string
    fqdn     = string
    priority = number
    protocol = string
  }))
}

variable "subnet_name" {
  description = "The name of the subnet used for the application gateway"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network used for the application gateway"
  type        = string
}

variable "rg_network" {
  description = "The name of the resource group for the network used for the application gateway"
  type        = string
}

variable "public_ip_name" {
  description = "The name of the public IP used for the application gateway"
  type        = string
}

variable "rg_public_ip" {
  description = "The resource group where the public IP is located"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the key vault used for the application gateway listener"
  type        = string
}

variable "rg_key_vault" {
  description = "The resource group where the key vault is located"
  type        = string
}

variable "ssl_certificate_name" {
  description = "Name to give to the certificate applied on the application gateway"
  type        = string
}

variable "secret_certificate_name" {
  description = "The name of the secret certificate in the key vault"
  type        = string
}

variable "managed_identity" {
  description = "The name of the managed identity used to access the key vault"
  type        = string
}

variable "rg_managed_identity" {
  description = "The resource group where the managed identity is located"
  type        = string
}

variable "min_capacity" {
  description = "Minimum value of instances the application gateway will have"
  type        = number
}

variable "max_capacity" {
  description = "Maximum value of instances the application gateway will have"
  type        = number
}
