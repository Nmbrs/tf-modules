resource "random_id" "storage_account_name" {
  # Arbitrary map of values that, when changed, will trigger recreation of resource
  # See: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
  keepers = {
    environment = "${var.environment}"
    project     = "${var.project}"
  }
  # Note: storage account name cannot be longer than 24 characters
  # Prefix length <= 20 chars and random id = 4 chars (2 bytes hex)
  prefix      = substr("sanmbrs${var.environment}${var.project}", 0, 20)
  byte_length = 2

}

resource "azurerm_storage_account" "storage_account" {
  name                      = random_id.storage_account_name.hex
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = data.azurerm_resource_group.rg.location
  account_kind              = var.kind
  account_tier              = var.account_tier
  account_replication_type  = var.replication_type
  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version           = var.min_tls_version
}
