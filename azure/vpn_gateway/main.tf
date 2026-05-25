resource "azurerm_public_ip" "vpn_gateway" {
  name                = local.public_ip_name
  domain_name_label   = local.vpn_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_virtual_network_gateway" "main" {
  name                = local.vpn_gateway_name
  location            = var.location
  resource_group_name = var.network_settings.vnet_resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  sku           = var.sku_name
  generation    = local.sku_generation[var.sku_name]

  ip_configuration {
    name                          = azurerm_public_ip.vpn_gateway.name
    public_ip_address_id          = azurerm_public_ip.vpn_gateway.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.subnet.id
  }

  vpn_client_configuration {
    address_space        = var.network_settings.address_spaces
    vpn_client_protocols = ["OpenVPN"]

    # Learn more about Azure AD authentication https://learn.microsoft.com/en-us/azure/vpn-gateway/openvpn-azure-ad-tenant
    aad_tenant   = local.aad_tenant_url
    aad_audience = local.vpn_enterprise_app_id
    aad_issuer   = local.aad_issuer_url
  }

  custom_route {
    address_prefixes = []
  }

  lifecycle {
    ignore_changes = [tags, custom_route]

    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null &&
        var.sequence_number != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or all of 'workload', 'company_prefix', and 'sequence_number' must be provided for automatic naming."
    }
  }
}
