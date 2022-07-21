variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network."
}

variable "name" {
  description = "The name of the virtual network."
  type        = string
}

variable "environment" {
  description = "(Optional) The environment in which the resource should be provisioned."
  type        = string

  validation {
    condition     = contains(["dev", "prod", "stag", "test", "sand"], var.environment)
    error_message = "The 'environment' value is invalid. Valid options are 'dev', 'prod','stag', 'test', 'sand'."
  }
}

variable "extra_tags" {
  description = "(Optional) A extra mapping of tags which should be assigned to the desired resource."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for tag in var.extra_tags : can(coalesce(tag))])
    error_message = "At least on tag value from 'extra_tags' is invalid. They must be non-empty string values."
  }
}

variable "address_spaces" {
  description = "The address space that is used the virtual network."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for address_space in var.address_spaces : can(cidrhost(address_space, 0))])
    error_message = "At least one of the values from 'address_spaces' property is invalid. They must be valid CIDR blocks."
  }

  validation {
    condition     = length(var.address_spaces) > 0
    error_message = "The 'address_spaces' property is an invalid list. The list must have at least one element."
  }
}

variable "subnets" {
  type = list(object({
    name              = string
    address_prefixes  = list(string)
    service_endpoints = list(string)
    enforce_private_link_service_network_policies = bool
    enforce_private_link_endpoint_network_policies = bool
    delegations = list(any)

  }))
  description = "List of objects that represent the configuration of each subnet."
  default     = []

  validation {
    condition     = alltrue([for subnet in var.subnets : can(coalesce(subnet.name))])
    error_message = "At least one 'name' property from 'subnets' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = alltrue([for subnet in var.subnets : alltrue([for address_prefix in subnet.address_prefixes : can(cidrhost(address_prefix, 0))])])
    error_message = "At least one of the values from 'address_prefixes' property from one of the 'subnets' is invalid. They must be valid CIDR blocks."
  }

  validation {
    condition     = alltrue([for subnet in var.subnets : length(subnet.address_prefixes) > 0])
    error_message = "At least one 'address_prefixes' property from one of the 'subnets' is an invalid list. They must have at least one element."
  }

  validation {
    condition     = alltrue([for subnet in var.subnets : alltrue([for address_prefix in subnet.address_prefixes : can(cidrhost(address_prefix, 0))])])
    error_message = "At least one of the values from 'address_prefixes' property from one of the 'subnets' is invalid. They must be valid CIDR blocks."
  }

  validation {
    condition = alltrue([
      for subnet in var.subnets : alltrue([
        for service_endpoint in subnet.service_endpoints : contains([
          "Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Web"
        ], service_endpoint)
      ])
    ])
    error_message = "At least one of the values from 'service_endpoint' property from one of the 'subnets' is invalid. Valid options are 'Microsoft.AzureActiveDirectory', 'Microsoft.AzureCosmosDB', 'Microsoft.ContainerRegistry', 'Microsoft.EventHub', 'Microsoft.KeyVault', 'Microsoft.ServiceBus', 'Microsoft.Sql', 'Microsoft.Storage', 'Microsoft.Web'."
  }

}
