locals {
  sequence_suffix = var.sequence_number == null ? "" : "-${format("%03d", var.sequence_number)}"

  # PostgreSQL Flexible Server naming following standard conventions
  # Format: psql-{company}-{workload}-{env}-{location}[-{seq}]
  # A null 'company_prefix' / 'workload' is rendered as "" only so that the naming precondition in
  # main.tf, rather than a template error, reports the missing component.
  postgresql_server_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("psql-${var.company_prefix == null ? "" : var.company_prefix}-${var.workload == null ? "" : var.workload}-${var.environment}-${var.location}${local.sequence_suffix}")
  )

  # A local administrator (login + generated password) only exists when Entra ID is not the
  # only authentication method.
  local_admin_enabled = !var.admin_settings.azuread_authentication_only_enabled

  # Burstable SKUs (B_Standard_*) do not support high availability.
  burstable_sku = startswith(var.sku_name, "B_")

  private_endpoint_subresources = ["postgresqlServer"]
}
