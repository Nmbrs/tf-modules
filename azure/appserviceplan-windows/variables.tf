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

variable "resource_group" {
  description = "azure resource group name."
  type        = string
}

variable "tags" {
  description = "nmbrs list of mandatory resource tags."
  type        = map(string)
}