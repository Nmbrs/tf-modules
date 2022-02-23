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
  description = "defines the app service plan type (i.e: Standard, Premium)."
  type        = string
}

variable "size" {
  description = "defines the app service size type (i.e: S1, P1V2 etc)."
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
  description = "Type of app service to be created eg. worker, web, mobile, api"
  type        = map(any)
}

variable "tags" {
  description = "nmbrs list of mandatory resource tags."
  type        = map(string)
}
