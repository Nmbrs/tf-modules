resource "azurerm_dns_a_record" "record" {
  for_each = { for a_record in var.a : a_record.name => a_record }
  name                = each.value.name
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_rg
  ttl                 = each.value.ttl
  records             = each.value.records
}

resource "azurerm_dns_cname_record" "record" {
  for_each = { for cname_record in var.cname : cname_record.name => cname_record }
  name                = each.value.name
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_rg
  ttl                 = each.value.ttl
  record              = each.value.record
}

resource "azurerm_dns_txt_record" "record" {
  for_each = { for txt_record in var.txt : txt_record.name => txt_record }

  name                = each.value.name
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_rg
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
}
