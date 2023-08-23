locals {
  # TenantID for the Azure AD tenant. Enter the tenant ID that corresponds to your configuration. Make sure the Tenant URL does not have a \ at the end.
  # Azure Public AD: https://login.microsoftonline.com/{AzureAD TenantID}
  aad_tenant_url = "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}"
  # The Application ID of the "Azure VPN" Azure AD Enterprise App
  # Azure Public: 41b23e61-6c1e-4545-b367-cd054e0ed4b4
  vpn_enterprise_app_id = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
  # URL of the Secure Token Service. Include a trailing slash at the end of the Issuer value. Otherwise, the connection may fail.
  # https://sts.windows.net/{AzureAD TenantID}/
  aad_issuer_url = "https://sts.windows.net/${data.azurerm_client_config.current.tenant_id}/"
}
