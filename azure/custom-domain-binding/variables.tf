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

variable "dns_zone_name" {
  description = "Name of the DNS zone"
  type        = string
}

variable "dns_zone_resource_group" {
  description = "Resource Group of the DNS zone"
  type        = string
}

variable "ttl" {
  description = "Time to live of records"
  type        = number
}

variable "certificate_keyvault_name" {
  description = "Certificate Keyvault"
  type        = string
}

variable "certificate_keyvault_resource_group" {
  description = "Resource group of the Certificate Keyvault"
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

variable "app_default_site_hostname" {
  description = "Name of the apps being binded"
  type        = map(string)
}
