locals {
  # Key Vault Managed HSM name following Azure naming convention
  # Format: kvmhsm-{company_prefix}-{workload}-{environment}
  key_vault_managed_hsm_name = (
    var.override_name != null && var.override_name != "" ?
    lower(var.override_name) :
    lower("kvmhsm-${var.company_prefix}-${var.workload}-${var.environment}")
  )
}
