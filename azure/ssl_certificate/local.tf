locals {
  certificate_name = "asc-${lower(replace(replace(var.domain_name, ".", "-"), "_", "-"))}"
}
