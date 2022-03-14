data "azurerm_client_config" "current" {}

# Create the Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  tags = merge(var.tags, local.auto_tags)
}

# Create a Default Azure Key Vault access policy with Admin permissions
# This policy must be kept for a proper run of the "destroy" process
resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  lifecycle {
    create_before_destroy = true
  }

  secret_permissions      = var.kv_secret_permissions_full
  certificate_permissions = var.kv_certificate_permissions_full
}

resource "azurerm_key_vault_access_policy" "readers_policy" {
  for_each = toset(var.readers)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = each.key
  secret_permissions      = var.kv_secret_permissions_read
  certificate_permissions = var.kv_certificate_permissions_read  
}

resource "azurerm_key_vault_access_policy" "writers_policy" {
  for_each                = toset(var.writers)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = each.key
  secret_permissions      = var.kv_secret_permissions_write
  certificate_permissions = var.kv_certificate_permissions_write
}