variable "dns_zone" {
  description = "Name of the DNS zone"
  type        = string
}

variable "a" {
  description = "A record to be created"
  type        = map(any)
}

variable "cname" {
  description = "CNAME record to be created"
  type        = map(any)
}

variable "txt" {
  description = "TXT record to be created"
  type        = map(any)
}
