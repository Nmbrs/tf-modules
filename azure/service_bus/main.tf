resource "azurerm_servicebus_namespace" "service_bus" {
  name                = "sb-nmbrs-${var.workload}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_name
  capacity            = var.capacity
  minimum_tls_version = "1.2"

  lifecycle {
    ignore_changes = [tags]

    ## capacity validation
    precondition {
      condition     = (var.sku_name == "Basic" && var.capacity == 0) || var.sku_name == "Standard" || var.sku_name == "Premium"
      error_message = format("Invalid value '%s' for variable 'capacity' (message units) when using the 'Basic' SKU, it must be 0.", var.capacity)
    }

    precondition {
      condition     = (var.sku_name == "Standard" && var.capacity == 0) || var.sku_name == "Basic" || var.sku_name == "Premium"
      error_message = format("Invalid value '%s' for variable 'capacity' (message units) when using the 'Standard' SKU, it must be 0.", var.capacity)
    }

    precondition {
      condition     = (var.sku_name == "Premium" && contains([1, 2, 4, 8, 16], var.capacity)) || var.sku_name == "Basic" || var.sku_name == "Standard"
      error_message = format("Invalid value '%s' for variable 'capacity' (message units) when using the 'Premium' SKU, valid options are 1, 2, 4, 8, 16.", var.capacity)
    }
  }
}

