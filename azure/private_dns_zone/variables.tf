variable "name" {
  description = "The name of the DNS Zone. Must be a valid domain name."
  type        = string

  # Microsft reserved zone names
  # For more information, see: https://learn.microsoft.com/en-us/azure/dns/private-dns-privatednszone#restrictions
  validation {
    condition = !contains(
      [
        "azclient.ms",
        "azure.com",
        "cloudapp.net",
        "core.windows.net",
        "microsoft.com",
        "msidentity.com",
        "trafficmanager.net",
        "windows.net",
        "azclient.us",
        "azure.us",
        "usgovcloudapp.net",
        "core.usgovcloudapi.net",
        "microsoft.us",
        "msidentity.us",
        "usgovtrafficmanager.net",
        "usgovcloudapi.net",
        "azclient.cn",
        "azure.cn",
        "chinacloudapp.cn",
        "core.chinacloudapi.cn",
        "microsoft.cn",
        "msidentity.cn",
        "trafficmanager.cn",
        "chinacloudapi.cn"
      ],
    var.name)
    error_message = format("Invalid value '%s' for variable 'name', The following list of reserved zone names are blocked from creation to prevent disruption of services: 'azclient.ms', 'azure.com', 'cloudapp.net', 'core.windows.net', 'microsoft.com', 'msidentity.com', 'trafficmanager.net', 'windows.net', 'azclient.us', 'azure.us', 'usgovcloudapp.net', 'core.usgovcloudapi.net', 'microsoft.us', 'msidentity.us', 'usgovtrafficmanager.net', 'usgovcloudapi.net', 'azclient.cn', 'azure.cn', 'chinacloudapp.cn', 'core.chinacloudapi.cn', 'microsoft.cn', 'msidentity.cn', 'trafficmanager.cn', 'chinacloudapi.cn'.", var.name)
  }

  # ICAAN rule and limit imposed by Microsoft on Azure Portal 
  # For more information, see: https://learn.microsoft.com/en-us/azure/dns/private-dns-privatednszone#restrictions
  validation {
    condition     = length(var.name) <= 253
    error_message = format("Invalid value '%s' for variable 'name'. The DNS zone name must contain no more than 253 characters.", var.name)
  }

  # ICAAN rule and limit imposed by Microsoft on Azure Portal 
  # For more information, see: https://learn.microsoft.com/en-us/azure/dns/private-dns-privatednszone#restrictions
  validation {
    condition     = length(split(".", var.name)) >= 2 && length(split(".", var.name)) <= 34 # Limit found on Azure Portal. For more information, see: https://learn.microsoft.com/en-us/azure/dns/private-dns-privatednszone#restrictions
    error_message = format("Invalid value '%s' for variable 'name'. The DNS zone name must have between 2 and 34 labels. For example, 'contoso.com' has 2 labels.", var.name)
  }

  # ICAAN rule according to ICANN Application Guidebook
  validation {
    condition     = alltrue([for label in split(".", var.name) : length(label) >= 1 && length(label) <= 63])
    error_message = format("Invalid value '%s' for variable 'name'. Each label must not exceed 63 characters.", var.name)
  }

  # Validating domain labels according to ICANN Application Guidebook
  validation {
    condition     = alltrue([for label in split(".", var.name) : can(regex("^[a-zA-Z0-9](?:[a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?$", label))])
    error_message = format("Invalid value '%s' for variable 'name'. Each label must consist of letters, numbers, or hyphens, and must not start or end with a hyphen.", var.name)
  }

  # Validating top level domain (rightmost label of a domain) according to ICANN Application Guidebook
  validation {
    condition     = can(regex("^[a-zA-Z0-9](?:[a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])", split(".", var.name)[length(split(".", var.name)) - 1]))
    error_message = format("Invalid value '%s' for variable 'name'. The TLD (rightmost label of a domain name) each label must consist of letters, numbers, or hyphens, and must not start or end with a hyphen. It must also be between 2 and 63 characters long.", var.name)
  }

  # Validating top level domains (rightmost label of a domain) against the RFC2606 list of reserved names
  validation {
    condition = !contains(
      [
        "test",
        "example",
        "invalid",
        "localhost"
      ], split(".", var.name)[length(split(".", var.name)) - 1]
    )
    error_message = format("Invalid value '%s' for variable 'name', The following list of reserved zone names are blocked from creation to prevent disruption of services: 'test', 'example', 'invalid', 'localhost'.", var.name)
  }
}

variable "resource_group_name" {
  description = "The name of an existing Resource Group."
  type        = string

  validation {
    condition     = can(coalesce(var.resource_group_name))
    error_message = "The 'resource_group_name' value is invalid. It must be a non-empty string."
  }
}

variable "vnet_links" {
  description = "List of objects that represent the configuration of each virtual network link."
  type = list(object({
    vnet_name            = string
    vnet_resource_group  = string
    registration_enabled = bool
  }))
  default = []

  validation {
    condition     = alltrue([for vnet_link in var.vnet_links : can(coalesce(vnet_link.vnet_name))])
    error_message = "At least one 'vnet_name' property from 'vnet_links' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for vnet_link in var.vnet_links : vnet_link.vnet_name]) == length(distinct([for vnet_link in var.vnet_links : vnet_link.vnet_name]))
    error_message = "At least one 'vnet_name' property from one of the 'vnet_links' is duplicated. They must be unique."
  }

  validation {
    condition     = alltrue([for vnet_link in var.vnet_links : can(coalesce(vnet_link.vnet_resource_group))])
    error_message = "At least one 'vnet_resource_group' property from 'vnet_links' is invalid. They must be non-empty string values."
  }

  validation {
    condition     = length([for vnet_link in var.vnet_links : vnet_link.vnet_resource_group]) == length(distinct([for vnet_link in var.vnet_links : vnet_link.vnet_resource_group]))
    error_message = "At least one 'vnet_resource_group' property from one of the 'vnet_links' is duplicated. They must be unique."
  }
}
