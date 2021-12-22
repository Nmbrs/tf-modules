data "azurerm_client_config" "current" {}

resource "random_password" "scaleset" {
  length  = 16
  special = true
  lower   = true
  upper   = true
  number  = true
}

data "azurerm_subnet" "scaleset" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_virtual_network_name
  resource_group_name  = var.vnet_resource_group_name
}


resource "azurerm_windows_virtual_machine_scale_set" "scaleset" {
  name                 = "${var.project}-${var.environment}"
  computer_name_prefix = "vmss"
  resource_group_name  = var.vm_resource_group
  location             = local.location
  sku                  = var.vm_size
  instances            = var.vm_count
  admin_username       = "adminuser"
  admin_password       = random_password.scaleset.result
  timezone             = "W. Europe Standard Time"
  overprovision        = false
  upgrade_mode         = "Automatic"

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
    name                 = "environment"
    publisher            = "Microsoft.Compute"
    type                 = "CustomScriptExtension"
    type_handler_version = "1.10"
    force_update_tag     = "1"
  
  settings = <<SETTINGS
  { "commandToExecute": "powershell -c [System.Environment]::SetEnvironmentVariable('Hangfire_BackgroundJobServerOptions_WorkerCount','${var.max_number_threads}',[System.EnvironmentVariableTarget]::Machine);[System.Environment]::SetEnvironmentVariable('Hangfire_BackgroundJobServerOptions_Queues','${var.queue_name}',[System.EnvironmentVariableTarget]::Machine)"     
  }
  SETTINGS
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