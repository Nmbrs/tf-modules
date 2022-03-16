output "a_fqdn" {
  value = azurerm_dns_a_record.record.fqdn
}

output "cname_fqdn" {
  value = azurerm_dns_cname_record.record.fqdn
}

output "txt_fqdn" {
  value = azurerm_dns_txt_record.record.fqdn
}
