data "azurerm_client_config" "current" {}

resource "random_password" "scaleset" {
    length           = 16
    special          = true
    override_special = "_%@"
}

data "azurerm_subnet" "scaleset" {
    name                 = var.vnet_name
    virtual_network_name = var.vnet_virtual_network_name
    resource_group_name  = var.vnet_resource_group_name
}

resource "azurerm_windows_virtual_machine_scale_set" "scaleset" {
    name                = "${var.project}"
    computer_name_prefix = "vmss"
    resource_group_name = var.vm_resource_group
    location            = local.location 
    sku                 = var.vm_size
    instances           = var.vm_count
    admin_username      = "adminuser"
    admin_password      = random_password.scaleset.result
    timezone            = "W. Europe Standard Time"

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2019-Datacenter"
        version   = "latest"
}

    os_disk {
        storage_account_type = "Premium_LRS"
        caching              = "ReadWrite"
}

    extension {
    name                       = "CustomScript"
    publisher                  = "Microsoft.Compute"
    type                       = "CustomScriptExtension"
    type_handler_version       = "1.10"
    auto_upgrade_minor_version = true

    settings = jsonencode({ "commandToExecute" = "powershell.exe -c \"[System.Environment]::SetEnvironmentVariable('Hangfire_BackgroundJobServerOptions_WorkerCount','10',[System.EnvironmentVariableTarget]::Machine)\"" })
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

resource "azurerm_virtual_machine_scale_set_extension" "extension" {
  name                         = "app_env_variables"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.scaleset.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  settings = jsonencode({
    "commandToExecute" = "echo $HOSTNAME"
  })

  depends_on = [ 
    azurerm_windows_virtual_machine_scale_set.scaleset
  ]
}
