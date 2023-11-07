output "name" {
  description = "The virtual network full name."
  value       = azurerm_virtual_network.vnet.name
}

output "workload" {
  description = "The virtual network workload name."
  value       = var.workload
}

output "id" {
  description = "The virtual network ID."
  value       = azurerm_virtual_network.vnet.id
}

output "subnets" {
  description = "Contains a list of the subnets data"
  value = [for subnet in azurerm_subnet.subnet : {
    name = subnet.name
    id   = subnet.id
    }
  ]
}

output "subnet_ids" {
  description = "Contains a list of the the resource id of the subnets"
  value       = { for subnet in azurerm_subnet.subnet : subnet.name => subnet.id }
}
