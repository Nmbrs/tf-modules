# SSH key
resource "tls_private_key" "ssh" {
  count     = var.os_type == "linux" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "azurerm_ssh_public_key" "ssh_public_key" {
  count               = var.os_type == "linux" ? 1 : 0
  name                = "ssh-${var.vm_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  public_key          = tls_private_key.ssh[0].public_key_openssh

  lifecycle {
    ignore_changes = [tags]
  }
}

# Windows password
resource "random_password" "password" {
  count   = var.os_type == "windows" ? 1 : 0
  length  = 32
  special = true
  keepers = {
    vm_name = trimspace(lower(var.vm_name))
  }
}

## Network interafaces
data "azurerm_subnet" "nic_subnet" {
  for_each = {
    # Create a mapping of the nic name to its settings
    for nic_settings in local.network_interfaces_settings : trimspace(lower(nic_settings.name)) => nic_settings
  }

  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.vnet_resource_group_name
}

resource "azurerm_network_interface" "nics" {
  # Create a mapping of the nic name to its settings
  for_each = { for nic_settings in local.network_interfaces_settings : trimspace(lower(nic_settings.name)) => nic_settings }

  name                = "nic-${var.vm_name}-${format("%03d", index(keys(local.network_interfaces_settings), each.key) + 1)}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.nic_subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

## Data Disks
resource "azurerm_managed_disk" "data_disks" {
  for_each = {
    for disk_settings in local.data_disks_settings : trimspace(lower(disk_settings.name)) => disk_settings
  }

  name                 = "dsk-${each.value.name}-${format("%03d", index(keys(local.data_disks_settings), each.key) + 1)}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = each.value.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = each.value.disk_size_gb

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disks" {
  for_each = {
    # Create a mapping of the disk name to its settings
    for disk_settings in local.data_disks_settings : trimspace(lower(disk_settings.name)) => disk_settings
  }

  # Use the ID of the corresponding managed disk
  managed_disk_id = azurerm_managed_disk.data_disks[each.key].id
  # Choose the virtual machine based on the OS type
  virtual_machine_id = var.os_type == "linux" ? azurerm_linux_virtual_machine.linux_vm[0].id : azurerm_windows_virtual_machine.windows_vm[0].id
  # Assign a unique LUN number to each disk, starting from #1
  lun     = index(local.data_disks_settings, each.value) + 1
  caching = each.value.caching
}

## Linux virtual machine
resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                           = var.os_type == "linux" ? 1 : 0
  name                            = var.vm_name
  computer_name                   = var.vm_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids           = [for nic in azurerm_network_interface.nics : nic.id]


  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh[0].public_key_openssh
  }

  os_disk {
    name                 = "dsk-${local.os_disk_settings.name}-os-001"
    caching              = local.os_disk_settings.caching
    storage_account_type = local.os_disk_settings.storage_account_type
  }

  source_image_reference {
    publisher = var.os_image.publisher
    offer     = var.os_image.offer
    sku       = var.os_image.sku
    version   = var.os_image.version
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

## Windows virtual machine
resource "azurerm_windows_virtual_machine" "windows_vm" {
  count                 = var.os_type == "windows" ? 1 : 0
  name                  = var.vm_name
  computer_name         = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = random_password.password[0].result
  network_interface_ids = [for nic in azurerm_network_interface.nics : nic.id]

  os_disk {
    name                 = local.os_disk_settings.name
    caching              = local.os_disk_settings.caching
    storage_account_type = local.os_disk_settings.storage_account_type
  }

  source_image_reference {
    publisher = var.os_image.publisher
    offer     = var.os_image.offer
    sku       = var.os_image.sku
    version   = var.os_image.version
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
