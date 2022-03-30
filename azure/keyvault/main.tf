data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurecaf_name" "caf_name" {
  name          = lower("${local.org}-${var.name}")
  resource_type = "azurerm_key_vault"
  suffixes      = [local.internal_external_suffix, lower(local.environment)]
  clean_input   = true
}

# Create the Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                       = azurecaf_name.caf_name.result
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  #tfsec:ignore:azure-keyvault-no-purge
  purge_protection_enabled = var.protection_enabled

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  // extra_tags is on the end to overwrite incorrect tags that already exists.
  tags = merge(local.default_tags, data.azurerm_resource_group.rg.tags, var.extra_tags)
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

  secret_permissions      = local.secrets_full_permissions
  certificate_permissions = local.certificates_full_permissions
}

data "azuread_application" "applications" {
  for_each     = toset(concat(var.readers.applications, var.writers.applications))
  display_name = each.key
}

data "azuread_group" "groups" {
  for_each         = toset(concat(var.readers.groups, var.writers.groups))
  display_name     = each.key
  security_enabled = true
}

data "azuread_user" "users" {
  for_each            = toset(concat(var.readers.users, var.writers.users))
  user_principal_name = each.key
}

resource "azurerm_key_vault_access_policy" "applications_readers_policy" {
  for_each                = toset(var.readers.applications)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_application.applications[each.key].object_id
  secret_permissions      = local.secrets_read_permissions
  certificate_permissions = local.certificates_read_permissions
}

resource "azurerm_key_vault_access_policy" "groups_readers_policy" {
  for_each                = toset(var.readers.groups)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_group.groups[each.key].object_id
  secret_permissions      = local.secrets_read_permissions
  certificate_permissions = local.certificates_read_permissions
}

resource "azurerm_key_vault_access_policy" "users_readers_policy" {
  for_each                = toset(var.readers.users)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_user.users[each.key].object_id
  secret_permissions      = local.secrets_read_permissions
  certificate_permissions = local.certificates_read_permissions
}

resource "azurerm_key_vault_access_policy" "applications_writers_policy" {
  for_each                = toset(var.writers.applications)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_application.applications[each.key].object_id
  secret_permissions      = local.secrets_write_permissions
  certificate_permissions = local.certificates_write_permissions
}

resource "azurerm_key_vault_access_policy" "groups_writers_policy" {
  for_each                = toset(var.writers.groups)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_group.groups[each.key].object_id
  secret_permissions      = local.secrets_write_permissions
  certificate_permissions = local.certificates_write_permissions
}

resource "azurerm_key_vault_access_policy" "users_writers_policy" {
  for_each                = toset(var.writers.users)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_user.users[each.key].object_id
  secret_permissions      = local.secrets_write_permissions
  certificate_permissions = local.certificates_write_permissions
}
