locals {
  sequence_suffix = var.sequence_number == null ? "" : "-${format("%03d", var.sequence_number)}"

  # PostgreSQL Flexible Server naming following standard conventions
  # Format: psql-{company}-{workload}-{env}-{location}[-{seq}]
  # The name stays null when the naming components are missing, so the precondition on the
  # server reports it instead of a template interpolation error.
  postgresql_flexible_server_name = (
    var.override_name != null ? lower(var.override_name) :
    var.workload == null || var.company_prefix == null ? null :
    lower("psql-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}${local.sequence_suffix}")
  )

  private_endpoint_subresources = ["postgresqlServer"]
}
