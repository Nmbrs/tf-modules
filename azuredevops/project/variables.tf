variable "name" {
  description = "The name of the Azure Dev Ops project"
  type        = string

  validation {
    condition     = length(var.name) <= 64
    error_message = "The project name must not contain more than 64 Unicode characters."
  }

  # System reserved name validation
  validation {
    condition = !contains([
      "AUX", "CON", "NUL", "PRN", "SERVER", "SignalR", "DefaultCollection",
      "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9", "COM10",
      "LPT1", "LPT2", "LPT3", "LPT4", "LPT5", "LPT6", "LPT7", "LPT8", "LPT9",
      "Web", "WEB"
    ], var.name)
    error_message = "The project name must not be a system reserved name like AUX, CON, PRN, or other reserved names."
  }

  # IIS reserved segments validation
  validation {
    condition = !contains([
      "App_Browsers", "App_code", "App_Data", "App_GlobalResources",
      "App_LocalResources", "App_Themes", "App_WebResources", "bin", "web.config"
    ], var.name)
    error_message = "The project name must not be a reserved IIS segment like 'App_Browsers', 'App_code', or 'web.config'."
  }
}

variable "contributors_groups" {
  description = "List of groups that will be contributors at the Azure DevOps project"
  type        = list(string)
}

variable "administrators_groups" {
  description = "List of groups that will be administrators at the Azure DevOps project"
  type        = list(string)
}

variable "readers_groups" {
  description = "List of groups that will be readers at the Azure DevOps project"
  type        = list(string)
}

# variable "service_connections" {
#   type = object({
#     azure = list(object({
#       name = string
#       managed_identity_name = string
#       managed_identity_resource_group_name = string
#     }))
#   })
# }
