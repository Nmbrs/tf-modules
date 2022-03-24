variable "name" {
  description = "The name of the DNS Zone. Must be a valid domain name."
  type        = string

  validation {
    condition     = length(var.name) >= 2 && length(var.name) <= 34 # Limit found on Azure portal
    error_message = "The 'name' value is invalid. It must be between 3 and 24 characters."
  }

  // Accordigly to ICANN Application Guidebook
  validation {
    condition     = can(regex("(?:\\.[[:alpha:]]{2,6})$", var.name))
    error_message = "The 'name' value is invalid. The last TLD (Top level domain) must be at least 2 characters long and no more than 6 characters long. It must also contain only letters."
  }

  validation {
    // Full Match Regex For DNS Zone name. It matches 1 or 2 subdomains + Top level domain. Example: 'subdomain1.subdomain2.topleveldomain'. 
    // Developer's note: Sorry about that big regex. I could not find better solution for that using the RE2 engine.
    condition     = can(regex("^(?:[[:alnum:]][a-zA-Z0-9-]+[[:alnum:]]\\.){1,2}(?:[[:alpha:]]{2,6})$", var.name))
    error_message = "The 'name' value is invalid. It must contain no more than 2 subdomains. Only letters, digits, and dashes are allowed in the subdomain name. However, the name must not end or begin with dashes. Valid Examples: 'subomain1.sudomain2.com', 'contoso.co.uk', 'example.com'."
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

variable "tags" {
  description = "A mapping of tags which should be assigned to the desired resource."
  type        = map(string)

  validation {
    condition     = alltrue([for tag in var.tags : can(coalesce(var.tags))])
    error_message = "At least on tag value from 'extra_tags' is invalid. They must be non-empty string values."
  }
}
