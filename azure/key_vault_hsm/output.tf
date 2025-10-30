output "name" {
  description = "The Key Vault Managed HSM name."
  value       = azurerm_key_vault_managed_hardware_security_module.main.name
}

output "workload" {
  description = "The workload name used for this Key Vault Managed HSM."
  value       = var.workload
}

output "id" {
  description = "The Key Vault Managed HSM resource ID."
  value       = azurerm_key_vault_managed_hardware_security_module.main.id
}

output "hsm_uri" {
  description = "The URI of the Key Vault Managed HSM, used for performing operations on keys and secrets."
  value       = azurerm_key_vault_managed_hardware_security_module.main.hsm_uri
}

output "admin_object_ids" {
  description = "List of Azure AD object IDs that have admin access to the Key Vault Managed HSM."
  value = [for group in data.azuread_group.admin_groups : {
    display_name = group.display_name
    object_id    = group.object_id
  }]
}
