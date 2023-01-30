output "name" {
  description = "The virtual machine name."
  value       = var.vm_name
}

output "os_type" {
  description = "The type of operating system to be installed on the virtual machine. Options are: windows, linux."
  value       = var.os_type
}

output "os_image" {
  description = "The details of the virtual machine's operating system  image"
  value = {
    publisher = local.os_image_settings.publisher
    offer     = local.os_image_settings.offer
    sku       = local.os_image_settings.sku
    version   = local.os_image_settings.version
  }
}

output "os_disk" {
  description = "The details of the virtual machine's operating system disk."
  value = {
    name                 = local.os_disk_settings.name
    caching              = local.os_disk_settings.caching
    storage_account_type = local.os_disk_settings.storage_account_type
  }
}

output "data_disk" {
  description = "The details of the virtual machine's data disks."
  value = [for disk in azurerm_managed_disk.data_disks : {
    name                 = disk.name
    storage_account_type = disk.storage_account_type
    disk_size_gb         = disk.disk_size_gb
    caching              = disk.caching
    }
  ]
}

output "network_interfaces" {
  description = "The details of the virtual machine's network interfaces."
  value = [for nic in azurerm_network_interface.nics : {
    name               = nic.name
    id                 = nic.id
    private_ip_address = nic.private_ip_address
    mac_address        = nic.mac_address
    subnet_id          = nic.subnet_id
    }
  ]
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
  value       = var.os_type == "linux" ? azurerm_linux_virtual_machine.linux_vm[0].admin_username : azurerm_windows_virtual_machine.windows_vm[0].admin_username
  sensitive   = true
}

# admin passwords should only be considered in case of windows machines, since linux authentication is passwordless
output "admin_password" {
  description = "The password used for administrator-level access to the virtual machine, only applicable for Windows-based virtual machines."
  value       = var.os_type == "windows" ? azurerm_windows_virtual_machine.windows_vm[0].admin_password : null
  sensitive   = true
}
