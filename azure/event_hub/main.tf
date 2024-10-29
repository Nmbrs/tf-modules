resource "azurerm_eventhub_namespace" "event_hub_namespace" {
  name                 = local.event_hub_namespace
  location             = var.location
  resource_group_name  = var.resource_group_name
  sku                  = "Standard"
  capacity             = 1
  auto_inflate_enabled = false

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_eventhub" "event_hub" {
  for_each            = length(var.event_hub) > 0 ? toset(var.event_hub) : toset([])
  name                = "evh-nmbrs-${each.value}-${var.environment}"
  namespace_name      = local.event_hub_namespace
  resource_group_name = var.resource_group_name
  partition_count     = 4
  message_retention   = 7
  depends_on          = [azurerm_eventhub_namespace.event_hub_namespace]
}

resource "azurerm_eventhub_consumer_group" "consumer_group" {
  for_each            = length(var.event_hub) > 0 ? toset(var.event_hub) : toset([])
  name                = "collector"
  namespace_name      = local.event_hub_namespace
  eventhub_name       = azurerm_eventhub.event_hub[each.value].name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_eventhub.event_hub]
}

resource "azurerm_eventhub_authorization_rule" "eventhub_authorization_rule" {
  for_each            = length(var.event_hub) > 0 ? toset(var.event_hub) : toset([])
  name                = "SecurityLogging"
  namespace_name      = local.event_hub_namespace
  eventhub_name       = azurerm_eventhub.event_hub[each.value].name
  resource_group_name = var.resource_group_name
  listen              = true
  send                = false
  manage              = false
  depends_on          = [azurerm_eventhub.event_hub]
}

