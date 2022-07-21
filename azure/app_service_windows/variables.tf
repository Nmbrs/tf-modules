variable "environment" {
  description = "defines the environment to provision the resources."
  type        = string
}

variable "project" {
  description = "project name. It will be used by some resources."
  type        = string
}

variable "location" {
  description = "location of the resource"
  type        = string
}

variable "plan" {
  description = "defines the app service size type (i.e: S1, P1V2 etc)."
  type        = string
}

variable "stack" {
  description = "defines the stack for the webapp (i.e dotnet, dotnetcore, node, python, php, and java)"
  type        = string
}

variable "dotnetVersion" {
  description = "defines the dotnet framework version for app service (i.e: v2.0 v4.0 v5.0 v6.0)."
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

variable "tags" {
  description = "nmbrs list of mandatory resource tags."
  type        = map(string)
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
  description = "Name of the key vault where the certificate is"
  type        = string
}

variable "certificate_keyvault_resource_group" {
  description = "Resource group of the Keyvault"
  type        = string
}

variable "certificate_name" {
  description = "Name of the certificate to bind"
  type        = string
}

