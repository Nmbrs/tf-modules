resource "azurerm_servicebus_namespace" "main" {
  name                          = local.service_bus_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku_name
  capacity                      = var.capacity
  premium_messaging_partitions  = var.premium_messaging_partitions
  public_network_access_enabled = var.firewall_settings.public_network_access_enabled
  minimum_tls_version           = "1.2"

  dynamic "network_rule_set" {
    for_each = var.sku_name == "Premium" ? [1] : []
    content {
      default_action                = length(var.firewall_settings.allowed_subnets) > 0 ? "Deny" : "Allow"
      public_network_access_enabled = var.firewall_settings.public_network_access_enabled
      trusted_services_allowed      = var.firewall_settings.trusted_services_bypass_firewall_enabled

      dynamic "network_rules" {
        for_each = var.firewall_settings.allowed_subnets
        content {
          subnet_id                            = data.azurerm_subnet.allowed_subnet[network_rules.value.subnet_name].id
          ignore_missing_vnet_service_endpoint = false
        }
      }
    }
  }

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

    ## premium_messaging_partitions validation — Premium SKU requires >= 1
    precondition {
      condition     = var.sku_name != "Premium" || var.premium_messaging_partitions >= 1
      error_message = format("Invalid value '%s' for variable 'premium_messaging_partitions' when using the 'Premium' SKU, it must be at least 1.", var.premium_messaging_partitions)
    }

    ## premium_messaging_partitions validation — non-Premium SKUs require 0
    precondition {
      condition     = var.sku_name == "Premium" || var.premium_messaging_partitions == 0
      error_message = format("Invalid value '%s' for variable 'premium_messaging_partitions' when using the '%s' SKU, it must be 0 (only Premium supports partitions).", var.premium_messaging_partitions, var.sku_name)
    }

    ## firewall_settings.allowed_subnets validation — Premium SKU required
    precondition {
      condition     = length(var.firewall_settings.allowed_subnets) == 0 || var.sku_name == "Premium"
      error_message = format("Invalid 'firewall_settings.allowed_subnets': VNet rules require the 'Premium' SKU. Current SKU: '%s'.", var.sku_name)
    }
  }
}
