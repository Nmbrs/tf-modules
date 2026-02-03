resource "azurerm_monitor_metric_alert" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = var.description
  severity            = var.severity
  enabled             = var.enabled
  auto_mitigate       = var.auto_mitigate
  frequency           = var.frequency
  window_size         = var.window_size

  criteria {
    metric_namespace = var.criteria.metric_namespace
    metric_name      = var.criteria.metric_name
    aggregation      = var.criteria.aggregation
    operator         = var.criteria.operator
    threshold        = var.criteria.threshold

    dynamic "dimension" {
      for_each = var.criteria.dimensions != null ? var.criteria.dimensions : []
      content {
        name     = dimension.value.name
        operator = dimension.value.operator
        values   = dimension.value.values
      }
    }
  }

  dynamic "action" {
    for_each = var.action_group_ids
    content {
      action_group_id = action.value
    }
  }

  tags = var.tags
}
