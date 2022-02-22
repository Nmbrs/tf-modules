variable "project" {
  description = "nmbrs project name to be used on the resource group name construction."
  type        = string
}

variable "tags" {
  description = "nmbrs list of mandatory resource tags."
  type        = map(string)
}

variable "environment" {
  # For a complete list of available Azure regions run at cli:  
  # az account list-locations  --query "[].{displayName:displayName, location:name}" --output table
  description = "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  type        = string
}

variable "location" {
  description = "azure resource region."
  type        = string
  default     = "westeurope"
}