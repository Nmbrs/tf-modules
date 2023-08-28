resource "azurerm_servicebus_namespace" "service_bus" {
  name                = "sb-${var.name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  capacity            = var.capacity
  minimum_tls_version = "1.2"

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [tags]

    precondition {
      condition     = (var.sku == "Basic" && var.capacity == 0) || (var.sku == "Standard" && var.capacity == 0) || var.sku == "Premium"
      error_message = "The capacity (message unit) must be 0 when using the 'Basic' or 'Standard' SKU."
    }
  }
}

