variable "organization" {
  description = "Organization name. It will be used by some resources."
  type        = string
}

variable "project" {
  description = "project name. It will be used by some resources."
  type        = string
}

variable "squad_name" {
  description = "squad owner of the service."
  type        = string
}

variable "squad_email" {
  description = "squad email"
  type        = string
}

variable "service" {
  description = "API name."
  type        = string
}

variable "api_backend_url" {
  description = "API backend url"
  type        = string
}

variable "path" {
  description = "API path"
  type        = string
  default     = "/"
}

variable "openapi_specs" {
  description = "API specification that follows OpenAPI v3.0"
  type        = string
}

variable "policy_payload" {
  description = "API policy XML content."
  type        = string
}

variable "tags" {
  description = "Resource tags."
  type = map
}

variable "environment" {
  description = "Nmbrs environment where is being deployed."
  type        = string
}