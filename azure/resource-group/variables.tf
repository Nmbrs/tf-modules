variable "name" {
  description = "(Required) The Azure resource group name to be used. The name must follow the CAF naming convention"
  type        = string
}

variable "tags" {
  description = "Azure resource tags map."
  type        = map(string)
}

variable "location" {
  # For a complete list of available Azure regions run at cli:  
  # az account list-locations  --query "[].{displayName:displayName, location:name}" --output table
  description = "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  type        = string
}
