output "id" {
  description = "The ID of the organization."
  value       = tfe_organization.organization.id
}

output "name" {
  description = "The name of the organization."
  value       = tfe_organization.organization.name
}
