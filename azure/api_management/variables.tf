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

variable "policy_product" {
  description = "API product policy XML content."
  type        = string
}

variable "tags" {
  description = "Resource tags."
  type        = map(any)
}

variable "environment" {
  description = "Nmbrs environment where is being deployed."
  type        = string
}

variable "vault_id" {
  description = "Secret Id that you want to get from the key vault"
  type        = string
}

variable "groups" {
  type = list(string)
  default = [
    "developers",
    "guests",
  ]
  description = "Groups to be assigned to the product"
}