data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurecaf_name" "caf_name" {
  name          = lower(var.name)
  resource_type = "azurerm_windows_virtual_machine"
  suffixes      = [lower(var.environment)]
  clean_input   = true
}


resource "azurerm_network_interface" "nic" {
  for_each            = { for nic in var.network_interfaces : nic.name => nic }
  name                = each.value.name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "main"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}
