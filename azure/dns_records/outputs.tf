output "a_fqdn" {
  description = "The FQDN of the A record"
  value       = { for k, fqdn in azurerm_dns_a_record.record : k => fqdn.fqdn }
}

output "cname_fqdn" {
  description = "The FQDN of the CNAME record"
  value       = { for k, fqdn in azurerm_dns_cname_record.record : k => fqdn.fqdn }
}

output "txt_fqdn" {
  description = "The FQDN of the TXT record"
  value       = { for k, fqdn in azurerm_dns_txt_record.record : k => fqdn.fqdn }
}
