

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

  # Validating top level domains (rightmost label of a domain).
  # The following top-level domains are supported by App Service domains: com, net, co.uk, org, nl, in, biz, org.uk, and co.in.
  validation {
    condition = contains(
      [
        "com",
        "net",
        "co.uk",
        "org",
        "nl",
        "biz",
        "org.uk",
        "co.in"
      ], split(".", var.name)[length(split(".", var.name)) - 1]
    )
    error_message = format("Invalid value '%s' for variable 'name'. The following top-level domain (rightmost label of a domain)are supported by App Service domains: 'com', 'net', 'co.uk', 'org', 'nl', 'in', 'biz', 'org.uk', and 'co.in'.", var.name)
  }
}

variable "dns_zone_resource_group_name" {
  type        = string
  description = "The name of the resource group where the Azure DNS Zone exists."
}

variable "contact" {
  type = object({
    address_line_1 = string
    address_line_2 = string
    city           = string
    country_code   = string
    postal_code    = string
    state          = string
    email          = string
    fax            = string
    name_first     = string
    name_last      = string
    name_middle    = string
    organization   = string
    job_title      = string
    phone          = string
  })
}
