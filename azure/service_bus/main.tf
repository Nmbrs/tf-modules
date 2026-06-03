resource "azurerm_servicebus_namespace" "main" {
  name                = local.service_bus_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku_name
  capacity            = var.capacity
  minimum_tls_version = "1.2"

  lifecycle {
    ignore_changes = [tags]

    ## Naming validation: Ensure either override_name is provided OR all naming components are provided
    precondition {
      condition = var.override_name != null || (
        var.workload != null &&
        var.company_prefix != null
      )
      error_message = "Invalid naming configuration: Either 'override_name' must be provided, or both 'workload' and 'company_prefix' must be provided for automatic naming."
    }

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
