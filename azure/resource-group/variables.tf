variable "project" {
  description = "nmbrs project name to be used on the resource group name construction."
  type        = string
}

variable "tags" {
  description = "nmbrs list of mandatory resource tags."
  type        = map(string)
}

variable "environment" {
  description = "nmbrs environment name."
  type        = string
}

variable "location" {
  description = "azure region where the nmbrs resource will be located"
  type = string
  default = "westeurope"
}