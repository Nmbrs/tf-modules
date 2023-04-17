
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = lower(var.name)
  resource_group_name = var.resource_group_name

  lifecycle {
    ignore_changes = [tags]
  }
}
