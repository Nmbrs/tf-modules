variable "vnet_source" {
  description = "object that represent the configuration of the source vnet to be peered."
  type = object({
    name                         = string
    resource_group_name          = string
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    allow_virtual_network_access = bool
    use_remote_gateways          = bool
  })

  validation {
    condition     = can(coalesce(var.vnet_source.name))
    error_message = format("Invalid value '%s' for 'name' property from 'vnet_source'. It must be a non-empty string value.", var.vnet_source.name)
  }

  validation {
    condition     = can(coalesce(var.vnet_source.resource_group_name))
    error_message = format("Invalid value '%s' for 'resource_group_name' property from 'vnet_source'. It must be a non-empty string value.", var.vnet_source.resource_group_name)
  }
}

variable "vnet_destination" {
  description = "object that represent the configuration of the destination vnet to be peered."
  type = object({
    name                         = string
    resource_group_name          = string
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    allow_virtual_network_access = bool
    use_remote_gateways          = bool
  })

  validation {
    condition     = can(coalesce(var.vnet_destination.name))
    error_message = format("Invalid value '%s' for 'name' property from 'vnet_destination'. It must be a non-empty string value.", var.vnet_destination.name)
  }

  validation {
    condition     = can(coalesce(var.vnet_destination.resource_group_name))
    error_message = format("Invalid value '%s' for 'resource_group_name' property from 'vnet_destination'. It must be a non-empty string value.", var.vnet_destination.resource_group_name)
  }
}

