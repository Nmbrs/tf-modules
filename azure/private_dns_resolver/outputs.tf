output "name" {
  description = "The private DNS resolver full name."
  value       = azurerm_private_dns_resolver.resolver.name
}

output "workload" {
  description = "The private DNS resolver workload name."
  value       = var.workload
}

output "id" {
  description = "The private DNS resolver ID."
  value       = azurerm_private_dns_resolver.resolver.id
}

output "virtual_network_name" {
  description = "The private DNS resolver virtual network name."
  value       = data.azurerm_virtual_network.vnet.name
}

output "virtual_network_id" {
  description = "The private DNS resolver virtual ntwork id."
  value       = data.azurerm_virtual_network.vnet.id
}

output "inbound_endpoints" {
  description = "The details of the inbound endpoints."
  value = [for endpoint in azurerm_private_dns_resolver_inbound_endpoint.inbound_endpoint : {
    name               = endpoint.name
    id                 = endpoint.id
    private_ip_address = endpoint.ip_configurations[0].private_ip_address
    subnet_id          = endpoint.ip_configurations[0].subnet_id
    }
  ]
}

output "outbound_endpoints" {
  description = "The details of the outbound endpoints."
  value = [for endpoint in azurerm_private_dns_resolver_outbound_endpoint.outbound_endpoint : {
    name      = endpoint.name
    id        = endpoint.id
    subnet_id = endpoint.subnet_id
    }
  ]
}
