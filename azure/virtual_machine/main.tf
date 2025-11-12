

# ==============================================================================
# SSH key
# ==============================================================================

resource "tls_private_key" "ssh" {
  count     = var.os_type == "linux" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "azurerm_ssh_public_key" "ssh_public_key" {
  count               = var.os_type == "linux" ? 1 : 0
  name                = local.ssh_public_key_name
  resource_group_name = var.resource_group_name
  location            = var.location
  public_key          = tls_private_key.ssh[0].public_key_openssh

  lifecycle {
    ignore_changes = [tags]
  }
}

# ==============================================================================
# Network Interface
# ==============================================================================
resource "azurerm_network_interface" "nic" {
  # Create a mapping of the nic name to its settings

  name                = local.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.nic_subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# ==============================================================================
# Data Disks
# ==============================================================================

resource "azurerm_managed_disk" "data_disks" {
  for_each = {
    for disk_settings in var.data_disks_settings :
    "${local.data_disk_name_prefix}-${format("%03d", disk_settings.sequence_number)}" => disk_settings
  }

  # Use the disk name as the name of the managed disk
  name                 = each.key
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
    for disk_settings in var.data_disks_settings :
    "${local.data_disk_name_prefix}-${format("%03d", disk_settings.sequence_number)}" => disk_settings
  }

  # Use the ID of the corresponding managed disk
  managed_disk_id = azurerm_managed_disk.data_disks[each.key].id
  # Choose the virtual machine based on the OS type
  virtual_machine_id = var.os_type == "linux" ? azurerm_linux_virtual_machine.linux_vm[0].id : azurerm_windows_virtual_machine.windows_vm[0].id
  # Assign a unique LUN number to each disk, starting from #1
  lun     = index(var.data_disks_settings, each.value) + 1
  caching = each.value.caching
}

# ==============================================================================
# Linux virtual machine
# ==============================================================================

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                           = var.os_type == "linux" ? 1 : 0
  name                            = local.vm_name
  computer_name                   = local.vm_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.sku_name
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.nic.id]


  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh[0].public_key_openssh
  }

  os_disk {
    name                 = local.os_disk_name
    caching              = var.os_disk_settings.caching
    storage_account_type = var.os_disk_settings.storage_account_type
  }

  source_image_reference {
    publisher = var.os_image_settings.publisher
    offer     = var.os_image_settings.offer
    sku       = var.os_image_settings.sku_name
    version   = var.os_image_settings.version
  }

  dynamic "identity" {
    for_each = var.managed_identity_settings != null ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = [data.azurerm_user_assigned_identity.vm[0].id]
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# ==============================================================================
# Windows virtual machine
# ==============================================================================


resource "random_password" "windows_vm" {
  count   = var.os_type == "windows" ? 1 : 0
  length  = 32
  special = true
  keepers = {
    vm_name = local.vm_name
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count                 = var.os_type == "windows" ? 1 : 0
  name                  = local.vm_name
  computer_name         = local.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = var.sku_name
  admin_username        = var.admin_username
  admin_password        = random_password.windows_vm[0].result
  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    name                 = local.os_disk_name
    caching              = var.os_disk_settings.caching
    storage_account_type = var.os_disk_settings.storage_account_type
  }

  source_image_reference {
    publisher = var.os_image_settings.publisher
    offer     = var.os_image_settings.offer
    sku       = var.os_image_settings.sku_name
    version   = var.os_image_settings.version
  }

  dynamic "identity" {
    for_each = var.managed_identity_settings != null ? [1] : []
    content {
      type         = "UserAssigned"
      identity_ids = [data.azurerm_user_assigned_identity.vm[0].id]
    }
  }

  lifecycle {
    ignore_changes = [tags]

    ## Windows NETBIOS name limitation validation
    precondition {
      condition     = length(local.vm_name) <= 15
      error_message = format("Invalid VM name '%s' for Windows virtual machine. The computer name must be 15 characters or less due to NETBIOS limitations. Current length: %d characters.", local.vm_name, length(local.vm_name))
    }
  }
}
