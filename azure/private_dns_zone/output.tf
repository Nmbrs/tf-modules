output "name" {
  description = "The DNS Zone name."
  value       = azurerm_private_dns_zone.private_dns_zone.name
}

output "id" {
  description = "The DNS Zone ID."
  value       = azurerm_private_dns_zone.private_dns_zone.id
}

output "number_of_record_sets" {
  description = "The number of records already in the zone."
  value       = azurerm_private_dns_zone.private_dns_zone.number_of_record_sets
}


output "max_number_of_record_sets" {
  description = "Maximum number of Records in the zone."
  value       = azurerm_private_dns_zone.private_dns_zone.max_number_of_record_sets
}

output "max_number_of_virtual_network_links" {
  description = "The maximum number of virtual networks that can be linked to this Private DNS zone."
  value       = azurerm_private_dns_zone.private_dns_zone.max_number_of_virtual_network_links
}

output "max_number_of_virtual_network_links_with_registration" {
  description = "The maximum number of virtual networks that can be linked to this Private DNS zone with registration enabled."
  value       = azurerm_private_dns_zone.private_dns_zone.max_number_of_virtual_network_links_with_registration
}


