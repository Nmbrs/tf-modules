output "name" {
  description = "The identity full name."
  value       = azurerm_user_assigned_identity.identity.name
}

output "workload" {
  description = "The identity workload name."
  value       = var.workload
}

output "id" {
  description = "The ID of the User Assigned Identity."
  value       = azurerm_user_assigned_identity.identity.id
}

output "client_id" {
  description = "The ID of the app associated with the identity."
  value       = azurerm_user_assigned_identity.identity.client_id
}

output "principal_id" {
  description = "The ID of the Service Principal object associated with the created identity."
  value       = azurerm_user_assigned_identity.identity.principal_id
}

output "tenant_id" {
  description = "The ID of the Tenant which the identity belongs to."
  value       = azurerm_user_assigned_identity.identity.tenant_id
}
