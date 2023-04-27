variable "name" {
  description = "The name of the DNS Zone. Must be a valid domain name."
  type        = string

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
