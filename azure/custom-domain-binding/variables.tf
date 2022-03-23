variable "location" {
  description = "location of the resource"
  type        = string
}

variable "resource_group" {
  description = "azure resource group name."
  type        = string
}

variable "apps" {
  description = "List of desired applications to be deployed on Azure app service resource (webapp, mobile, identity, others)."
  type        = map(any)
}

variable "dns_zone" {
  description = "Name of the DNS zone"
  type        = string
}

variable "keyvault_name" {
  description = "Name of the key vault where the certificate is"
  type        = string
}

variable "certificate_name" {
  description = "Name of the certificate to bind"
  type        = string
}

variable "app_name" {
  description = "Name of the apps being binded"
  type        = map(any)
}
