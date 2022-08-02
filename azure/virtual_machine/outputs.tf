output "name" {
  description = "The virtual machine name."
  value       = azurecaf_name.caf_name_linux_vm.result
}

output "os_type" {
  description = "The virtual machine name."
  value       = local.os_type
}

output "os_image" {
  description = "The virtual machine name."
  value = {
    publisher = local.os_image[var.os_type].publisher
    offer     = local.os_image[var.os_type].offer
    sku       = local.os_image[var.os_type].sku
    version   = local.os_image[var.os_type].version
  }
}
