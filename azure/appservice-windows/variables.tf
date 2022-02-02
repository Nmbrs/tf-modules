variable "environment" {
  description = "defines the environment to provision the resources."
  type        = string
}

variable "project" {
  description = "project name. It will be used by some resources."
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
  description = "defines the dotnet framework version for app service (i.e: 4.6, 4.7, 4.8)."
  type        = string
}

variable "resource_group" {
  description = "azure resource group name."
  type        = string
}

variable "vnet" {
  description = "azure nmbrs vnet information struct that holds vnet required information."
  type = map(string)
  default = {
    name: "default"
    resource_group_name: "default"
  }
}