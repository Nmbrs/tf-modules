output "name" {
  description = "The virtual machine name."
  value       = var.vm_name
}

output "os_type" {
  description = "The virtual machine O.S. type."
  value       = var.os_type
}

output "os_image" {
  description = "The virtual machine image details."
  value = {
    publisher = var.os_image.publisher
    offer     = var.os_image.offer
    sku       = var.os_image.sku
    version   = var.os_image.version
  }
}

output "ssh_public_key" {
  description = "The SSH public key of the virtual machine, used for secure access."
  value       = var.os_type == "linux" ? tls_private_key.ssh[0].public_key_openssh : null
  sensitive   = true
}

output "ssh_private_key" {
  description = "The SSH private key of the virtual machine, used for secure access."
  value       = var.os_type == "linux" ? tls_private_key.ssh[0].private_key_openssh : null
  sensitive   = true
}

output "admin_username" {
  description = "The username used for administrator-level access to the virtual machine."
  value       = var.os_type == "linux" ? azurerm_linux_virtual_machine.linux_vm.admin_username : azurerm_windows_virtual_machine.windows_vm.admin_username
  sensitive   = true
}

# admin passwords shoul only be considered in case of windows machines, since linux authentication is passwordless
output "admin_password" {
  description = "The password used for administrator-level access to the virtual machine, only applicable for Windows-based virtual machines."
  value       = var.os_type == "windows" ? azurerm_windows_virtual_machine.windows_vm.admin_password : null
  sensitive   = true
}
