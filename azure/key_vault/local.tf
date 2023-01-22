locals {
  internal_external_suffix = var.external_usage ? "e" : "i"

  org         = "nmbrs"
  environment = var.environment

  certificates_full_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
  keys_full_permissions         = []
  secrets_full_permissions      = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
  storage_full_permissions      = []

  certificates_read_permissions = ["Get", "List"]
  keys_read_permissions         = []
  secrets_read_permissions      = ["Get", "List"]
  storage_read_permissions      = []

  certificates_write_permissions = ["Get", "List", "Update", "Delete"]
  keys_write_permissions         = []
  secrets_write_permissions      = ["Get", "List", "Set", "Delete"]
  storage_write_permissions      = []
}
