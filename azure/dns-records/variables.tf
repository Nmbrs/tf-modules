variable "dns_zone" {
  description = "Name of the DNS zone"
  type        = string
}

variable "cname" {
  description = "Type of app service to be created eg. worker, web, mobile, api"
  type        = map(any)
}

variable "txt" {
  description = "Type of app service to be created eg. worker, web, mobile, api"
  type        = map(any)
}