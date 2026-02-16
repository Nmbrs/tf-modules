output "name" {
  description = "The virtual machine name."
  value       = local.vm_name
}

output "os_type" {
  description = "The type of operating system to be installed on the virtual machine. Options are: windows, linux."
  value       = var.os_type
}

output "os_image" {
  description = "The details of the virtual machine's operating system image"
  value = {
    source = var.os_image_settings.source
    # Marketplace image details (populated when source = "marketplace")
    publisher = var.os_image_settings.source == "marketplace" ? var.os_image_settings.publisher : null
    offer     = var.os_image_settings.source == "marketplace" ? var.os_image_settings.offer : null
    sku_name  = var.os_image_settings.source == "marketplace" ? var.os_image_settings.sku_name : null
    version   = var.os_image_settings.source == "marketplace" ? var.os_image_settings.version : null
    # Shared Image Gallery details (populated when source = "shared_gallery")
    gallery_name                = var.os_image_settings.source == "shared_gallery" ? var.os_image_settings.gallery_name : null
    gallery_resource_group_name = var.os_image_settings.source == "shared_gallery" ? var.os_image_settings.gallery_resource_group_name : null
    image_name                  = var.os_image_settings.source == "shared_gallery" ? var.os_image_settings.image_name : null
    image_version               = var.os_image_settings.source == "shared_gallery" ? var.os_image_settings.image_version : null
  }
}

output "os_disk" {
  description = "The details of the virtual machine's operating system disk."
  value = {
    name                 = local.os_disk_name
    storage_account_type = var.os_disk_settings.storage_account_type
  }
}

output "data_disks" {
  description = "The details of the virtual machine's data disks."
  value = [for disk in azurerm_managed_disk.data_disks : {
    name                 = disk.name
    storage_account_type = disk.storage_account_type
    disk_size_gb         = disk.disk_size_gb
    }
  ]
}

output "network_interface" {
  description = "The details of the virtual machine's network interfaces."
  value = {
    name               = azurerm_network_interface.nic.name
    id                 = azurerm_network_interface.nic.id
    private_ip_address = azurerm_network_interface.nic.private_ip_address
    mac_address        = azurerm_network_interface.nic.mac_address
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
  value       = var.os_type == "linux" ? azurerm_linux_virtual_machine.linux_vm[0].admin_username : azurerm_windows_virtual_machine.windows_vm[0].admin_username
  sensitive   = true
}

# admin passwords should only be considered in case of windows machines, since linux authentication is passwordless
output "admin_password" {
  description = "The password used for administrator-level access to the virtual machine, only applicable for Windows-based virtual machines."
  value       = var.os_type == "windows" ? azurerm_windows_virtual_machine.windows_vm[0].admin_password : null
  sensitive   = true
}
