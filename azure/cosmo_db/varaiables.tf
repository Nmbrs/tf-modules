variable "kind" {
  description = "defines the Kind of CosmosDB to create - possible values are GlobalDocumentDB, MongoDB and Parse."
  type        = string

  validation {
    condition     = contains(["GlobalDocumentDB", "MongoDB", "Parse"], var.kind)
    error_message = format("Invalid value '%s' for variable 'kind', Valid options are 'GlobalDocumentDB', 'MongoDB', 'Parse'.", var.kind)
  }
}

variable "mongo_db_version" {
  description = "(Optional) The Server Version of a MongoDB account. Possible values are 4.2, 4.0, 3.6, and 3.2."
  type        = string

  validation {
    condition     = contains(["4.2", "4.0", "3.6", "3.2"], var.mongo_db_version)
    error_message = format("Invalid value '%s' for variable 'mongo_db_version', Valid options are '4.2', '4.0', '3.6' and '3.2'.", var.mongo_db_version)
  }
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the resource group."
  type        = string
}

variable "name" {
  description = "(Required) Specifies the name of the resource"
  type        = string
}

variable "extra_tags" {
  description = "(Optional) A extra mapping of tags which should be assigned to the desired resource."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for tag in var.extra_tags : can(coalesce(var.extra_tags))])
    error_message = "At least on tag value from 'extra_tags' is invalid. They must be non-empty string values."
  }
}