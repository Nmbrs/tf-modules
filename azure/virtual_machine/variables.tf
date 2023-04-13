variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group."
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "environment" {
  description = "The environment in which the resource should be provisioned."
  type        = string
}

variable "vm_size" {
  description = "The SKU which should be used for this Virtual Machine. For an exaustive list of virtual, please use the command 'az vm list-sizes --location 'your-location''."
  type        = string
  default     = "Standard_DS2_v2"

  validation {
    condition     = contains(["Standard_DS2_v2", "Standard_D4as_v5", "Standard_D8as_v5", "Standard_F4s_v2", "Standard_F8s_v2", "Standard_F16s_v2"], var.vm_size)
    error_message = format("Invalid value '%s' for variable 'vm_size', valid options are 'Standard_D2s_v2', 'Standard_D4as_v5', 'Standard_D8as_v5','Standard_F4s_v2', 'Standard_F8s_v2', 'Standard_F16s_v2'.", var.vm_size)
  }
}

variable "os_type" {
  description = "Type of virtual machine to be created. Acceptable values are 'dev', 'test', 'prod' or 'sand'."
  type        = string

  validation {
    condition     = contains(["linux", "windows"], var.os_type)
    error_message = format("Invalid value '%s' for variable 'os_type', valid options are 'linux', 'windows'.", var.os_type)
  }
}

variable "os_image" {
  description = "The operating system image for a virtual machine."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })

  validation {
    condition     = can(coalesce(trimspace(var.os_image.publisher)))
    error_message = format("Invalid value '%s' for variable 'os_image.publisher', It must be non-empty string values.", var.os_image.publisher)
  }

  validation {
    condition     = can(coalesce(trimspace(var.os_image.offer)))
    error_message = format("Invalid value '%s' for variable 'os_image.offer', It must be non-empty string values.", var.os_image.offer)
  }

  validation {
    condition     = can(coalesce(trimspace(var.os_image.sku)))
    error_message = format("Invalid value '%s' for variable 'os_image.sku', It must be non-empty string values.", var.os_image.publisher)
  }

  validation {
    condition     = can(coalesce(trimspace(var.os_image.version)))
    error_message = format("Invalid value '%s' for variable 'os_image.version', It must be non-empty string values.", var.os_image.version)
  }

}

variable "admin_username" {
  description = "(Optional) Specifies The administrator username for which the SSH Key or password should be configured."
  type        = string
  default     = "automation"
}

variable "network_interfaces" {
  description = "A list of network interface objects, each containing information about a network interface to be created in the deployment."
  type = list(object({
    name                     = string
    vnet_resource_group_name = string
    vnet_name                = string
    subnet_name              = string
  }))
  default = []

  validation {
    condition     = alltrue([for nic in var.network_interfaces : can(coalesce(trimspace(nic.name)))])
    error_message = "At least one 'name' property from 'network_interfaces' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for nic in var.network_interfaces : nic.name]) == length(distinct([for nic in var.network_interfaces : trimspace(lower(nic.name))]))
    error_message = "At least one 'name' property from one of the 'network_interfaces' is duplicated. They must be unique."
  }

  validation {
    condition     = alltrue([for nic in var.network_interfaces : can(coalesce(nic.vnet_resource_group_name))])
    error_message = "At least one 'vnet_resource_group_name' property from 'network_interfaces' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = alltrue([for nic in var.network_interfaces : can(coalesce(nic.vnet_name))])
    error_message = "At least one 'vnet_name' property from 'network_interfaces' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = alltrue([for nic in var.network_interfaces : can(coalesce(nic.subnet_name))])
    error_message = "At least one 'subnet_name' property from 'network_interfaces' is invalid. They must be non-empty string values."
  }

}

variable "os_disk" {
  description = "O.S. disk to be attached to the deployment."
  type = object({
    name                 = string
    storage_account_type = string
    caching              = string
  })

  validation {
    condition     = can(coalesce(trimspace(var.os_disk.name)))
    error_message = format("Invalid value '%s' for variable 'os_disk.name)', It must be non-empty string values.", var.os_disk.name)
  }

  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "StandardSSD_ZRS", "Premium_ZRS"], var.os_disk.storage_account_type)
    error_message = format("Invalid value '%s' for variable 'os_disk.storage_account_type', Valid options are 'Standard_LRS', 'StandardSSD_LRS','Premium_LRS', 'StandardSSD_ZRS','Premium_ZRS'.", var.os_disk.storage_account_type)
  }

  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.os_disk.caching)
    error_message = format("Invalid value '%s' for variable 'os_disk.caching'. Valid options are 'None', 'ReadOnly','ReadWrite'.", var.os_disk.caching)
  }
}

variable "data_disks" {
  description = "A list of data disk objects, each containing information about a data disk to be attached to the deployment."
  type = list(object({
    name                 = string
    storage_account_type = string
    disk_size_gb         = number
    caching              = string
  }))
  default = []

  validation {
    condition     = alltrue([for disk in var.data_disks : can(trimspace(disk.name))])
    error_message = "At least one 'name' property from 'data_disks' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for disk in var.data_disks : disk.name]) == length(distinct([for disk in var.data_disks : trimspace(lower(disk.name))]))
    error_message = "At least one 'name' property from one of the 'data_disks' is duplicated. They must be unique."
  }

  validation {
    condition     = alltrue([for disk in var.data_disks : contains(["Standard_LRS", "StandardSSD_ZRS", "Premium_LRS", "PremiumV2_LRS", "Premium_ZRS", "StandardSSD_LRS", "UltraSSD_LRS"], disk.storage_account_type)])
    error_message = "At least one 'storage_account_type' property from 'data_disks' is invalid. Valid options are 'Standard_LRS', 'StandardSSD_ZRS','Premium_LRS', 'PremiumV2_LRS','Premium_ZRS', 'StandardSSD_LRS','UltraSSD_LRS'."
  }

  validation {
    condition     = alltrue([for disk in var.data_disks : disk.disk_size_gb >= 1 && disk.disk_size_gb <= 1000])
    error_message = "At least one 'disk_size_gb' property from 'data_disks' is invalid. They must be must be between 1 and 1000 GB."
  }

  validation {
    condition     = alltrue([for disk in var.data_disks : contains(["None", "ReadOnly", "ReadWrite"], disk.caching)])
    error_message = "At least one 'caching' property from 'data_disks' is invalid. Valid options are 'None', 'ReadOnly','ReadWrite'."
  }
}
