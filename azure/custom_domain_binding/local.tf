locals {
  full_hostname   = "${var.cname_record_name}.${var.dns_zone_name}"
  txt_record_name = "asuid.${var.cname_record_name}.${var.dns_zone_name}"
}


