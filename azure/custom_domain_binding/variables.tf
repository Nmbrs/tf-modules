# variable "resource_group_name" {
#   description = "azure resource group name."
#   type        = string
# }

# variable "apps" {
#   description = "List of desired applications to be deployed on Azure app service resource (webapp, mobile, identity, others)."
#   type        = map(any)
# }

variable "app_name" {
  description = "Name of the apps being binded"
  type        = string
}

variable "dns_zone_name" {
  description = "Name of the DNS zone"
  type        = string
}

variable "dns_zone_resource_group" {
  description = "Resource Group of the DNS zone"
  type        = string
}

variable "cname_record_name" {
  description = "Time to live of records"
  type        = string
}

variable "cname_record_ttl" {
  description = "Time to live of records"
  type        = string
  default     = 300
}

# # variable "certificate_keyvault_resource_group" {
# #   description = "Resource group of the Certificate Keyvault"
# #   type        = string
# # }

# variable "certificate_name" {
#   description = "Name of the certificate to bind"
#   type        = string
# }

variable "app_default_site_hostname" {
  description = "Name of the apps being binded"
  type        = map(string)
}
