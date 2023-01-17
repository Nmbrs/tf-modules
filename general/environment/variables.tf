variable "environment" {
  type        = string
  description = "The environment where the resources will be deployed. Acceptable values are 'dev', 'test', 'prod' or 'sand'."
  validation {
    condition     = contains(["dev", "test", "prod", "sand"], var.environment)
    error_message = format("Invalid value '%s' for variable 'environment', valid options are 'dev', 'test', 'prod', 'sand'.", var.environment)
  }
}

