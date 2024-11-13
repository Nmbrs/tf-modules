resource "azurerm_eventhub_namespace" "event_hub_namespace" {
  name                     = local.event_hub_namespace
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = var.sku #change to variable
  capacity                 = var.capacity
  auto_inflate_enabled     = var.auto_inflate_enabled
  maximum_throughput_units = var.maximum_throughput_units

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_eventhub" "event_hub" {
  #for_each            = var.event_hubs_settings
  for_each            = { for hub in var.event_hubs_settings[0].name : hub => hub }
  name                = each.key #change to object list
  namespace_name      = local.event_hub_namespace
  resource_group_name = var.resource_group_name
  partition_count     = var.event_hubs_settings[0].consumer_groups[0].partition_count
  message_retention   = var.event_hubs_settings[0].consumer_groups[0].message_retention #change according to sku
  depends_on          = [azurerm_eventhub_namespace.event_hub_namespace]
}

resource "azurerm_eventhub_consumer_group" "consumer_group" {
  # for_each            = var.event_hubs_settings
  for_each            = { for hub in var.event_hubs_settings : hub.name[0] => hub.consumer_groups }
  name                = each.value[0].name #change to object list
  namespace_name      = local.event_hub_namespace
  eventhub_name       = azurerm_eventhub.event_hub[each.key].name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_eventhub.event_hub]
}

resource "azurerm_eventhub_authorization_rule" "eventhub_authorization_rule" {
  for_each            = { for hub in var.event_hubs_settings : hub.name[0] => hub.eventhub_authorization_rule }
  name                = each.value[0].name #change to object list
  namespace_name      = local.event_hub_namespace
  eventhub_name       = azurerm_eventhub.event_hub[each.key].name
  resource_group_name = var.resource_group_name
  listen              = each.value[0].listen #change to object list
  send                = each.value[0].send   #change to object list
  manage              = each.value[0].manage #change to object list
  depends_on          = [azurerm_eventhub.event_hub]
}

