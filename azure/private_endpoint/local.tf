locals {
  private_endpoint_name   = "pep-${var.resource_settings.name}-${lower(var.resource_settings.subresource_name)}"
  service_connection_name = "sc-${var.resource_settings.name}-${lower(var.resource_settings.subresource_name)}"
}
