variable "environment" {
  description = "defines the environment to provision the resources."
  type        = string
}

variable "project" {
  description = "project name. It will be used by some resources."
  type        = string
}

variable "appserviceplanid" {
  type = string
  description = "Id of the appservice plan to connect the apps"
}

variable "dotnetVersion" {
  description = "defines the dotnet framework version for app service (i.e: v2.0 v4.0 v5.0 v6.0)."
  type        = string
}

variable "resource_group" {
  description = "azure resource group name."
  type        = string
}

variable "vnet_subnet_id" {
  type        = string
  description = "azure vnet subnet id that is going to be associated with the app service."
}

variable "tags" {
  description = "nmbrs list of mandatory resource tags."
  type        = map(string)
}