variable "override_name" {
  description = "Optional override for naming logic."
  type        = string
  nullable    = true
  default     = null


  validation {
    condition     = var.override_name == null || try(length(trimspace(var.override_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'override_name', it must be null or a non-empty string.", coalesce(var.override_name, "null"))
  }
}

variable "workload" {
  description = "Short, descriptive name for the application, service, or workload. Used in resource naming conventions."
  type        = string
  nullable    = true

  validation {
    condition     = var.workload == null || try(length(trimspace(var.workload)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'workload', it must be null or a non-empty string.", coalesce(var.workload, "null"))
  }
}

variable "sequence_number" {
  description = "A numeric value used to ensure uniqueness for resource names."
  type        = number
  nullable    = true

  validation {
    condition     = var.sequence_number == null || try(var.sequence_number >= 1 && var.sequence_number <= 999, false)
    error_message = format("Invalid value '%s' for variable 'sequence_number', it must be null or a number between 1 and 999.", coalesce(var.sequence_number, "null"))
  }
}

variable "location" {
  description = "Specifies Azure location where the resources should be provisioned. For an exhaustive list of locations, please use the command 'az account list-locations -o table'."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = format("Invalid value '%s' for variable 'location', it must be a non-empty string.", var.location)
  }
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["dev", "test", "prod", "sand", "stag"], var.environment)
    error_message = format("Invalid value '%s' for variable 'environment', valid options are 'dev', 'test', 'prod', 'sand', 'stag'.", var.environment)
  }
}

variable "resource_group_name" {
  description = "Specifies the name of the resource group where the resource should be provisioned."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = format("Invalid value '%s' for variable 'resource_group_name', it must be a non-empty string.", var.resource_group_name)
  }
}


variable "sku_name" {
  description = "The SKU which should be used for this Virtual Machine. For an exaustive list of virtual, please use the command 'az vm list-sizes --location 'your-location''."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "os_type" {
  description = "Type of operating system to be installed on the virtual machine. Acceptable values are 'linux', 'windows'."
  type        = string

  validation {
    condition     = contains(["linux", "windows"], var.os_type)
    error_message = format("Invalid value '%s' for variable 'os_type', valid options are 'linux', 'windows'.", var.os_type)
  }
}

variable "os_image_settings" {
  description = "The operating system image for a virtual machine."
  type = object({
    publisher = string
    offer     = string
    sku_name  = string
    version   = string
  })

  validation {
    condition     = can(coalesce(trimspace(var.os_image_settings.publisher)))
    error_message = format("Invalid value '%s' for variable 'os_image.publisher', It must be non-empty string values.", var.os_image_settings.publisher)
  }

  validation {
    condition     = can(coalesce(trimspace(var.os_image_settings.offer)))
    error_message = format("Invalid value '%s' for variable 'os_image.offer', It must be non-empty string values.", var.os_image_settings.offer)
  }

  validation {
    condition     = can(coalesce(trimspace(var.os_image_settings.sku_name)))
    error_message = format("Invalid value '%s' for variable 'os_image.sku', It must be non-empty string values.", var.os_image_settings.sku_name)
  }

  validation {
    condition     = can(coalesce(trimspace(var.os_image_settings.version)))
    error_message = format("Invalid value '%s' for variable 'os_image.version', It must be non-empty string values.", var.os_image_settings.version)
  }

}

variable "admin_username" {
  description = "(Optional) Specifies The administrator username for which the SSH Key or password should be configured."
  type        = string
  default     = "automation"
}

variable "network_settings" {
  description = "Settings related to the network connectivity of the virtual machine."
  type = object({
    vnet_name                = string
    vnet_resource_group_name = string
    subnet_name              = string
  })

  nullable = false

  validation {
    condition     = try(length(trimspace(var.network_settings.vnet_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'network_settings.vnet_name', it must be a non-empty string.", coalesce(var.network_settings.vnet_name, "null"))
  }

  validation {
    condition     = try(length(trimspace(var.network_settings.vnet_resource_group_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'network_settings.vnet_resource_group_name', it must be a non-empty string.", coalesce(var.network_settings.vnet_resource_group_name, "null"))
  }

  validation {
    condition     = try(length(trimspace(var.network_settings.subnet_name)) > 0, false)
    error_message = format("Invalid value '%s' for variable 'network_settings.subnet_name', it must be a non-empty string.", coalesce(var.network_settings.subnet_name, "null"))
  }
}

variable "os_disk_settings" {
  description = "O.S. disk to be attached to the deployment."
  type = object({
    storage_account_type = string
    caching              = string
  })

  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "StandardSSD_ZRS", "Premium_ZRS"], var.os_disk_settings.storage_account_type)
    error_message = format("Invalid value '%s' for variable 'os_disk.storage_account_type', Valid options are 'Standard_LRS', 'StandardSSD_LRS','Premium_LRS', 'StandardSSD_ZRS','Premium_ZRS'.", var.os_disk_settings.storage_account_type)
  }

  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.os_disk_settings.caching)
    error_message = format("Invalid value '%s' for variable 'os_disk.caching'. Valid options are 'None', 'ReadOnly','ReadWrite'.", var.os_disk_settings.caching)
  }
}

variable "data_disks_settings" {
  description = "A list of data disk objects, each containing information about a data disk to be attached to the deployment."
  type = list(object({
    sequence_number      = number
    storage_account_type = string
    disk_size_gb         = number
    caching              = string
  }))
  default = []

  validation {
    condition     = alltrue([for disk in var.data_disks_settings : contains(["Standard_LRS", "StandardSSD_ZRS", "Premium_LRS", "PremiumV2_LRS", "Premium_ZRS", "StandardSSD_LRS", "UltraSSD_LRS"], disk.storage_account_type)])
    error_message = "At least one 'storage_account_type' property from 'data_disks' is invalid. Valid options are 'Standard_LRS', 'StandardSSD_ZRS','Premium_LRS', 'PremiumV2_LRS','Premium_ZRS', 'StandardSSD_LRS','UltraSSD_LRS'."
  }

  validation {
    condition     = alltrue([for disk in var.data_disks_settings : disk.disk_size_gb >= 1 && disk.disk_size_gb <= 1000])
    error_message = "At least one 'disk_size_gb' property from 'data_disks' is invalid. They must be must be between 1 and 1000 GB."
  }

  validation {
    condition     = alltrue([for disk in var.data_disks_settings : contains(["None", "ReadOnly", "ReadWrite"], disk.caching)])
    error_message = "At least one 'caching' property from 'data_disks' is invalid. Valid options are 'None', 'ReadOnly','ReadWrite'."
  }
}

variable "managed_identity_settings" {
  description = "Settings related to the managed identity. If null, no managed identity will be assigned to the VM."
  type = object({
    name                = string
    resource_group_name = string
  })
  nullable = true
  default  = null

  validation {
    condition = (
      var.managed_identity_settings == null ||
      (try(length(trimspace(var.managed_identity_settings.name)) > 0, false) &&
      try(length(trimspace(var.managed_identity_settings.resource_group_name)) > 0, false))
    )
    error_message = "When managed_identity_settings is provided, both 'name' and 'resource_group_name' must be non-empty strings."
  }
}
