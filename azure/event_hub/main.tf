resource "azurerm_eventhub_namespace" "event_hub_namespace" {
  name                     = local.event_hub_namespace
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = var.sku
  capacity                 = var.capacity
  auto_inflate_enabled     = var.auto_inflate_enabled
  maximum_throughput_units = var.maximum_throughput_units

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_eventhub" "event_hub" {
  for_each            = { for hub in var.event_hubs_settings : hub.name => hub }
  name                = each.key
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  resource_group_name = var.resource_group_name
  partition_count     = each.value.consumer_groups[0].partition_count
  message_retention   = each.value.consumer_groups[0].message_retention
}

resource "azurerm_eventhub_consumer_group" "consumer_group" {
  for_each = {
    for pair in flatten([
      for hub in var.event_hubs_settings : [
        for cg in hub.consumer_groups : {
          hub_name = hub.name
          cg_name  = cg.name
          cg       = cg
        }
      ]
    ]) : "${pair.hub_name}-${pair.cg_name}" => pair
  }
  name                = each.value.cg_name
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  eventhub_name       = azurerm_eventhub.event_hub[each.value.hub_name].name
  resource_group_name = var.resource_group_name
}

resource "azurerm_eventhub_authorization_rule" "eventhub_authorization_rule" {
  for_each = {
    for pair in flatten([
      for hub in var.event_hubs_settings : [
        for rule in hub.authorization_rules : {
          hub_name = hub.name
          rule     = rule
        }
      ]
    ]) : "${pair.hub_name}-${pair.rule.name}" => pair
  }
  name                = each.value.rule.name
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  eventhub_name       = azurerm_eventhub.event_hub[each.value.hub_name].name
  resource_group_name = var.resource_group_name
  listen              = each.value.rule.listen
  send                = each.value.rule.send
  manage              = each.value.rule.manage
}
