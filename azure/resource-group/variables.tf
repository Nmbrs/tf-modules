variable "name" {
  type        = string
  description = "Specifies the name of the the resource."
}

variable "location" {
  description = "Specifies the Azure Region where the resource should exists. Warning: Changing this forces a resource to be recreated."
  type        = string
}


variable "tags" {
  description = "List of mandatory resource tags."
  type        = map(string)

  validation {
    condition     = can(coalesce(lookup(var.tags, "environment", null)))
    error_message = "The tag \"environment\" is missing or its value is null or empty."
  }

  validation {
    condition     = can(coalesce(lookup(var.tags, "product", null)))
    error_message = "The tag \"product\" is missing or its value is null or empty."
  }

  validation {
    condition     = can(coalesce(lookup(var.tags, "squad", null)))
    error_message = "The tag \"environment\" is missing or its value is null or empty."
  }

  validation {
    condition     = can(coalesce(lookup(var.tags, "country", null)))
    error_message = "The tag \"squad\" is missing or its value is null or empty."
  }
}


