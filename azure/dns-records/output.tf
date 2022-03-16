output "a_fqdn" {
  value = { for k, fqdn in azurerm_dns_a_record.record : k => fqdn.fqdn }
}

output "cname_fqdn" {
  value = { for k, fqdn in azurerm_dns_cname_record.record : k => fqdn.fqdn }
}

output "txt_fqdn" {
  value = { for k, fqdn in azurerm_dns_txt_record.record : k => fqdn.fqdn }
}
