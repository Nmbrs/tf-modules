locals {
  sequence_suffix = var.sequence_number == null ? "" : "-${format("%03d", var.sequence_number)}"

  # PostgreSQL Flexible Server naming following standard conventions
  # Format: pgsql-{company}-{workload}-{env}-{location}[-{seq}]
  # The name stays null when the naming components are missing, so the precondition on the
  # server reports it instead of a template interpolation error.
  postgresql_flexible_server_name = (
    var.override_name != null ? lower(var.override_name) :
    var.workload == null || var.company_prefix == null ? null :
    lower("pgsql-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}${local.sequence_suffix}")
  )

  private_endpoint_subresources = ["postgresqlServer"]

  # The private endpoint is named "pep-{server name}-{subresource}" (see the private_endpoint module)
  # and Azure caps private endpoint names at 80 characters, which bounds the server name.
  max_server_name_length = 80 - length("pep--${lower(local.private_endpoint_subresources[0])}")
  server_name_length     = local.postgresql_flexible_server_name == null ? 0 : length(local.postgresql_flexible_server_name)

  # A local administrator (login + generated password) only exists when Entra ID is not the
  # only authentication method.
  local_admin_enabled = !var.admin_settings.azuread_authentication_only_enabled

  # Burstable SKUs (B_Standard_*) do not support high availability.
  burstable_sku = startswith(var.sku_name, "B_")
}
