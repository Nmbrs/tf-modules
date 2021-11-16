output "subnet_id" {
    value = data.azurerm_subnet.scaleset.id
}

output "admin_username" {
    value = azurerm_windows_virtual_machine_scale_set.scaleset.admin_username    
}

output "admin_password" {
    value = azurerm_windows_virtual_machine_scale_set.scaleset.admin_password
    sensitive = true
}