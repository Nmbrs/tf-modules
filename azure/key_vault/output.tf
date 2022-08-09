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

output "readers_policies" {
  description = "List of readers access policies."
  value = [for policy in azurerm_key_vault_access_policy.readers_policy : {
    name      = var.policies[index(var.policies.*.object_id, policy.object_id)].name
    object_id = policy.object_id
    }
  ]
}

output "writers_policies" {
  description = "List of writers access policies."
  value = [for policy in azurerm_key_vault_access_policy.writers_policy : {
    name      = var.policies[index(var.policies.*.object_id, policy.object_id)].name
    object_id = policy.object_id
    }
  ]
}
