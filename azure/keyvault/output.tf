output "key_vault_id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.key_vault.id
}

output "key_vault_url" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.key_vault.vault_uri
}

output "key_vault_secrets" {
  value = values(azurerm_key_vault_secret.secret).*.value
}
