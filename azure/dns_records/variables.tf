variable "dns_zone_name" {
  description = "Name of the DNS zone"
  type        = string
}

variable "dns_zone_rg" {
  description = "Resource Group of the DNS Zone"
  type        = string
}

variable "a" {
  description = "A record to be created"
  type = list(object({
    name    = string
    records = list(string)
    ttl     = number
  }))
  default = []
}

variable "cname" {
  description = "CNAME record to be created"
  type = list(object({
    name   = string
    record = string
    ttl    = number
  }))
  default = []
}

variable "txt" {
  description = "TXT record to be created"
  type = list(object({
    name    = string
    records = list(string)
    ttl     = number
  }))
  default = []
}
