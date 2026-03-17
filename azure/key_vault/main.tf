data "azurerm_client_config" "current" {}

# Create the Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                = local.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name                      = var.sku_name
  soft_delete_retention_days    = 31
  purge_protection_enabled      = true
  enable_rbac_authorization     = var.rbac_authorization_enabled
  public_network_access_enabled = var.public_network_access_enabled

  network_acls {
    bypass         = var.trusted_services_bypass_firewall_enabled ? "AzureServices" : "None"
    default_action = "Deny"
  }

  lifecycle {
    ignore_changes = [tags]

    ## Naming validation: Ensure either override_name is provided OR all naming components are provided
    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or both 'workload' and 'company_prefix' must be provided for automatic naming."
    }

    ## access policies validation
    precondition {
      condition     = (var.rbac_authorization_enabled && length(var.access_policies) == 0 || !var.rbac_authorization_enabled)
      error_message = "Invalid value for the variable 'access_policies'. It must be an empty list when the variable `rbac_authorization_enabled` is set to truth."
    }
  }
}

# Create a Default Azure Key Vault access policy with Admin permissions
# This policy must be kept for a proper run of the "destroy" process
resource "azurerm_key_vault_access_policy" "default_policy" {
  count = var.rbac_authorization_enabled ? 0 : 1

  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_client_config.current.object_id
  certificate_permissions = local.certificates_full_permissions
  key_permissions         = local.keys_full_permissions
  secret_permissions      = local.secrets_full_permissions
  storage_permissions     = local.storage_full_permissions

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_key_vault_access_policy" "readers_policy" {
  for_each = {
    for policy in var.access_policies : trimspace(lower(policy.name)) => policy
    if policy.type == "readers" && !var.rbac_authorization_enabled
  }

  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = each.value.object_id
  certificate_permissions = local.certificates_read_permissions
  key_permissions         = local.keys_read_permissions
  secret_permissions      = local.secrets_read_permissions
  storage_permissions     = local.storage_read_permissions
}

resource "azurerm_key_vault_access_policy" "writers_policy" {
  for_each = {
    for policy in var.access_policies : trimspace(lower(policy.name)) => policy
    if policy.type == "writers" && !var.rbac_authorization_enabled
  }

  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = each.value.object_id
  certificate_permissions = local.certificates_write_permissions
  key_permissions         = local.keys_write_permissions
  secret_permissions      = local.secrets_write_permissions
  storage_permissions     = local.storage_write_permissions
}

resource "azurerm_key_vault_access_policy" "administrators_policy" {
  for_each = {
    for policy in var.access_policies : trimspace(lower(policy.name)) => policy
    if policy.type == "administrators" && !var.rbac_authorization_enabled
  }

  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = each.value.object_id
  certificate_permissions = local.certificates_full_permissions
  key_permissions         = local.keys_full_permissions
  secret_permissions      = local.secrets_full_permissions
  storage_permissions     = local.storage_full_permissions
}
