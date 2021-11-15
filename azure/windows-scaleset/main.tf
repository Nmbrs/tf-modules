data "azurerm_client_config" "current" {}

resource "random_password" "scaleset" {
    length           = 16
    special          = true
    override_special = "_%@"
}

data "azurerm_subnet" "scaleset" {
    name                 = "backend"
    virtual_network_name = "VNET-NetworkPayrollTestNL"
    resource_group_name  = "RG-NetworkPayrollTestNL"
}

resource "azurerm_windows_virtual_machine_scale_set" "scaleset" {
    name                = "vmss-${var.project}"
    resource_group_name = var.vm_resourcegroup
    location            = local.location 
    sku                 = var.vm_size
    instances           = var.vm_count
    admin_username      = "adminuser"
    admin_password      = random_password.scaleset.result

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-Datacenter-Server"
        version   = "latest"
}

    os_disk {
        storage_account_type = "Premium_LRS"
        caching              = "ReadWrite"
}

    network_interface {
        name    = "vmss-${var.project}-nic"
        primary = true

    ip_configuration {
        name      = "vmss-${var.project}-ip"
        primary   = true
        subnet_id = data.azurerm_subnet.scaleset.id
    }
  }
}
