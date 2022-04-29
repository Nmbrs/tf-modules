output "name" {
  description = "The Key Vault Key name."
  value       = azurerm_key_vault.key_vault.name
}

output "id" {
  description = "The Key Vault Key ID."
  value       = azurerm_key_vault.key_vault.id
}

output "uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.key_vault.vault_uri
}
