data "azurerm_client_config" "current" {}

# Create the Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                       = local.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 31
  #tfsec:ignore:azure-keyvault-no-purge
  purge_protection_enabled = var.protection_enabled

  network_acls {
    #tfsec:ignore:azure-keyvault-specify-network-acl
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# Create a Default Azure Key Vault access policy with Admin permissions
# This policy must be kept for a proper run of the "destroy" process
resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

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
    for policy in var.policies : trimspace(lower(policy.name)) => policy
    if policy.type == "readers"
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
    for policy in var.policies : trimspace(lower(policy.name)) => policy
    if policy.type == "writers"
  }
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = each.value.object_id
  certificate_permissions = local.certificates_write_permissions
  key_permissions         = local.keys_write_permissions
  secret_permissions      = local.secrets_write_permissions
  storage_permissions     = local.storage_write_permissions
}
