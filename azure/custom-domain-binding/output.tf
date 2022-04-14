output "custom_domain" {
  value = { for k, domain in azurerm_app_service_custom_hostname_binding.binding : k => domain.hostname }
}

output "certificate_thumbprint" {
  value = data.azurerm_key_vault_certificate.binding.thumbprint
}
