variable "service_plan_name" {
  description = "The name which should be used for this Service Plan."
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "environment" {
  description = "defines the environment to provision the resources."
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}


variable "os_type" {
  description = "The O/S type for the App Services to be hosted in this plan. Changing this forces a new AppService to be created."
  type        = string
  default     = "Windows"

  validation {
    condition     = contains(["Linux", "Windows", "WindowsContainer"], var.os_type)
    error_message = format("Invalid value '%s' for variable 'os_type', valid options are 'Linux', 'Windows', 'WindowsContainer'.", var.os_type)
  }
}

variable "sku_name" {
  description = "Defines the The SKU for the plan. (i.e: S1, P1V2 etc)."
  type        = string

  validation {
    condition     = contains(["B1", "B2", "B3", "I1", "I2", "I3", "I1v2", "I2v2", "I3v2", "I4v2", "I5v2", "I6v2", "P1v2", "P2v2", "P3v2", "P0v3", "P1v3", "P2v3", "P3v3", "P1Mv3", "P2Mv3", "P3Mv3", "P4Mv3", "P5Mv3", "S1", "S2", "S3", "WS1", "WS2", "WS3"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku', valid options are 'B1', 'B2', 'B3', 'I1', 'I2', 'I3', 'I1v2', 'I2v2', 'I3v2', 'I4v2', 'I5v2', 'I6v2', 'P1v2', 'P2v2', 'P3v2', 'P0v3', 'P1v3', 'P2v3', 'P3v3', 'P1Mv3', 'P2Mv3', 'P3Mv3', 'P4Mv3', 'P5Mv3', 'S1', 'S2', 'S3', 'WS1', 'WS2', 'WS3'.", var.sku_name)
  }
}

variable "stack" {
  description = "defines the stack for the webapp (i.e dotnet, dotnetcore, node, python, php, and java)"
  type        = string

}

variable "dotnet_version" {
  description = "defines the dotnet framework version for app service (i.e: v3.0 v4.0 v5.0 v6.0)."
  type        = string
}

variable "load_balancing_mode" {
  description = "The O/S type for the App Services to be hosted in this plan. Changing this forces a new AppService to be created."
  type        = string
  default     = "LeastResponseTime"

  validation {
    condition     = contains(["WeightedRoundRobin", "LeastRequests", "LeastResponseTime", "WeightedTotalTraffic", "RequestHash", "PerSiteRoundRobin"], var.load_balancing_mode)
    error_message = format("Invalid value '%s' for variable 'os_type', valid options are 'WeightedRoundRobin', 'LeastRequests', 'LeastResponseTime', 'WeightedTotalTraffic', 'RequestHash', 'PerSiteRoundRobin'.", var.load_balancing_mode)
  }
}

variable "app_service_names" {
  description = "List of desired applications to be deployed on Azure app service resource (webapp, mobile, identity, others)."
  type        = list(string)
}

variable "network_settings" {
  type = object(
    {
      subnet_name              = string
      vnet_name                = string
      vnet_resource_group_name = string
    }
  )
}
