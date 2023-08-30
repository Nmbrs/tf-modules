output "service_plan_id" {
  description = "The ID of the Azure Service Plan."
  value       = azurerm_service_plan.service_plan.id
}

output "service_plan_os_type" {
  description = "The operating system type associated with the Azure Service Plan."
  value       = azurerm_service_plan.service_plan.os_type
}

output "service_plan_sku" {
  description = "The SKU name associated with the Azure Service Plan."
  value       = azurerm_service_plan.service_plan.sku_name
}

output "app_services" {
  description = "List of Azure Windows Web Apps with their respective names and IDs."
  value = [for app in azurerm_windows_web_app.web_app : {
    name = app.name
    id   = app.id
  }]
}


