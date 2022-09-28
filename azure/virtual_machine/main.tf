data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurecaf_name" "caf_name_vm" {
  name          = lower(var.name)
  resource_type = "azurerm_virtual_machine"
  suffixes      = [lower(var.environment)]
  clean_input   = true
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "azurerm_ssh_public_key" "ssh_public_key" {
  name                = azurecaf_name.caf_name_vm.result
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = data.azurerm_resource_group.rg.tags
  public_key          = tls_private_key.ssh.public_key_openssh

  lifecycle {
    ignore_changes = [
      tags["created_at"],
      tags["updated_at"]
    ]
  }
}

resource "random_string" "nic_unique_id" {
  length  = 4
  special = false
  upper   = false

  keepers = {
    vm_name = lower(var.name)
  }
}

resource "azurecaf_name" "caf_name_nic" {
  name          = azurecaf_name.caf_name_vm.result
  resource_type = "azurerm_network_interface"
  suffixes      = [random_string.nic_unique_id.result]
  clean_input   = true
}

resource "random_password" "password" {
  length  = 32
  special = true
  keepers = {
    vm_name = lower(var.name)
  }
}


resource "azurerm_network_interface" "main_nic" {
  name                = azurecaf_name.caf_name_nic.result
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = data.azurerm_resource_group.rg.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  lifecycle {
    ignore_changes = [
      tags["created_at"],
      tags["updated_at"]
    ]
  }
}



resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = local.os_type == "linux" ? 1 : 0
  name                = azurecaf_name.caf_name_vm.result
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = merge(local.default_tags, data.azurerm_resource_group.rg.tags, var.extra_tags)
  size                = "Standard_D2s_v3"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.main_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = local.os_image[var.os_type].publisher
    offer     = local.os_image[var.os_type].offer
    sku       = local.os_image[var.os_type].sku
    version   = local.os_image[var.os_type].version
  }

  lifecycle {
    ignore_changes = [
      tags["created_at"],
      tags["updated_at"]
    ]
  }
}
