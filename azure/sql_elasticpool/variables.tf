variable "workload" {
  description = "This variable defines the name of the resource."
  type        = string
}

variable "environment" {
  description = "Defines the environment to provision the resources."
  type        = string

}

variable "location" {
  description = "The location where the resources will be deployed in Azure. For an exaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
}

variable "capacity" {
  description = "The capacity of the elastic pool."
  type        = number

  validation {
    condition     = var.capacity % 2 == 0
    error_message = "The capacity must be an even number."
  }

  validation {
    condition     = var.capacity >= 2
    error_message = "The capacity must be greater than or equal to 2."
  }
}

variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string

}

variable "max_size_gb" {
  description = "The maximum size of the elastic pool in gigabytes."
  type        = number

  validation {
    condition     = var.max_size_gb >= 512
    error_message = "The capacity must be greater than or equal to 512."
  }
}

variable "resource_group_name" {
  description = "Resource group name for where the resource will be created"
  type        = string
}
