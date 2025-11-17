data "azurerm_subnet" "nic_subnet" {
  name                 = var.network_settings.subnet_name
  virtual_network_name = var.network_settings.vnet_name
  resource_group_name  = var.network_settings.vnet_resource_group_name
}

data "azurerm_user_assigned_identity" "vm" {
  count               = var.managed_identity_settings != null ? 1 : 0
  name                = var.managed_identity_settings.name
  resource_group_name = var.managed_identity_settings.resource_group_name
}

data "azurerm_shared_image" "vm" {
  count               = var.os_image_settings.source == "shared_gallery" ? 1 : 0
  name                = var.os_image_settings.image_name
  gallery_name        = var.os_image_settings.gallery_name
  resource_group_name = var.os_image_settings.gallery_resource_group_name
}
