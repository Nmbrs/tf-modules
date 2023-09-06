resource "azurerm_servicebus_namespace" "service_bus" {
  name                = "sb-${var.workload}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_name
  capacity            = var.capacity
  minimum_tls_version = "1.2"

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [tags]

    precondition {
      condition     = (var.sku_name == "Basic" && var.capacity == 0) || (var.sku_name == "Standard" && var.capacity == 0) || var.sku_name == "Premium"
      error_message = "The capacity (message unit) must be 0 when using the 'Basic' or 'Standard' SKU."
    }
  }
}

