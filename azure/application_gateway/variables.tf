variable "workload" {
  description = "value"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "name" {
  description = "The workload name of the app insights component."
  type        = string
}

variable "instance_count" {
  description = ""
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
  type = map(object({
    name     = string
    fqdn     = string
    priority = number
    protocol = string
  }))

}

# variable "host_name" {
#   description = "Hostname the listener will be waiting for e.g. test.contoso.com"
# }

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "rg_network" {
  description = "The name of the resource group for the network"
  type        = string
}

variable "public_ip_name" {
  description = "The name of the public IP"
  type        = string
}

variable "rg_public_ip" {
  description = "The resource group where the public IP is located"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the key vault"
  type        = string
}

variable "rg_key_vault" {
  description = "The resource group where the key vault is located"
  type        = string
}

variable "ssl_certificate_name" {
  description = "Name to give to the certificate applied on the app gw"
  type        = string
}

variable "secret_certificate_name" {
  description = "The name of the secret certificate in the key vault"
  type        = string
}

variable "managed_identity" {
  description = "The name of the managed identity"
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
