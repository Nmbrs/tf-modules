locals {
  default_tags = {
    ProvisionedBy = "Terraform"
  }

  internal_external_suffix = var.external_usage ? "e" : "i"

  org         = "nmbrs"
  environment = var.environment

  secrets_full_permissions       = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
  certificates_full_permissions  = ["Backup", "Create", "Delete", "Deleteissuers", "Get", "Getissuers", "Import", "List", "Listissuers", "Managecontacts", "Manageissuers", "Purge", "Recover", "Restore", "Setissuers", "Update"]
  secrets_read_permissions       = ["Get", "List"]
  certificates_read_permissions  = ["Get", "List"]
  secrets_write_permissions      = ["Get", "List", "Set", "Delete"]
  certificates_write_permissions = ["Get", "List", "Update", "Delete"]
}
