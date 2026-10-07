locals {
  # TenantID for the Azure AD tenant. Enter the tenant ID that corresponds to your configuration. Make sure the Tenant URL does not have a \ at the end.
  # Azure Public AD: https://login.microsoftonline.com/{AzureAD TenantID}
  aad_tenant_url = "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}"
  # Microsoft-registered Azure VPN Client app ID (supports Linux, Windows, and macOS).
  # Replaces the legacy manually registered app ID (41b23e61-6c1e-4545-b367-cd054e0ed4b4) which only supported Windows and macOS.
  # See: https://learn.microsoft.com/en-us/azure/virtual-wan/point-to-site-entra-gateway-update
  vpn_enterprise_app_id = "c632b3df-fb67-4d84-bdcf-b95ad541b5c8"
  # URL of the Secure Token Service. Include a trailing slash at the end of the Issuer value. Otherwise, the connection may fail.
  # https://sts.windows.net/{AzureAD TenantID}/
  aad_issuer_url = "https://sts.windows.net/${data.azurerm_client_config.current.tenant_id}/"

  # Optimal generation per SKU: Gen2 when supported (better throughput), Gen1 for legacy SKUs, None for ExpressRoute.
  # See: https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways
  sku_generation = {
    "Basic"            = "Generation1"
    "Standard"         = "Generation1"
    "HighPerformance"  = "Generation1"
    "UltraPerformance" = "Generation1"
    "VpnGw1"           = "Generation1"
    "VpnGw1AZ"         = "Generation1"
    "VpnGw2"           = "Generation2"
    "VpnGw2AZ"         = "Generation2"
    "VpnGw3"           = "Generation2"
    "VpnGw3AZ"         = "Generation2"
    "VpnGw4"           = "Generation2"
    "VpnGw4AZ"         = "Generation2"
    "VpnGw5"           = "Generation2"
    "VpnGw5AZ"         = "Generation2"
    "ErGw1AZ"          = "None"
    "ErGw2AZ"          = "None"
    "ErGw3AZ"          = "None"
  }

  # Format: vpng-{company}-{workload}-{env}-{location}-{seq}
  vpn_gateway_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("vpng-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )

  public_ip_name = "pip-${local.vpn_gateway_name}"
}
