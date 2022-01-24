variable "organization" {
  description = "Organization name. It will be used by some resources."
  type        = string
}

variable "country" {
  description = "defines the resource country short code tag (ie: NL, SE)"
  type        = string
}

variable "squad" {
  description = "defines the resource squad owner tag"
  type        = string
}

variable "environment" {
  description = "defines the environment to provision the resources."
  type        = string
}

variable "product" {
  description = "defines the resource nmbrs product tag"
  type        = string
}

variable "project" {
  description = "project name. It will be used by some resources."
  type        = string
}

variable "plan" {
  description = "defines the app service plan type (i.e: Standard, Premium)."
  type = string
}

variable "size" {
  description = "defines the app service size type (i.e: S1, P1V2 etc)."
  type = string
}

variable "stack" {
  description = "defines the stack for app service (i.e: .Net, Python, Java)."
  type = string
}

variable "dotnetVersion" {
  description = "defines the dotnet framework version for app service (i.e: 4.6, 4.7, 4.8)."
  type = string
}