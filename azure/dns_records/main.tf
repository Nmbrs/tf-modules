resource "azurerm_dns_a_record" "record" {
  for_each = {
    for key, value in var.a : key => value
    if value.name != ""
  }
  name                = each.value["name"]
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_rg
  ttl                 = each.value["ttl"]
  records             = each.value["records"]
}

resource "azurerm_dns_cname_record" "record" {
  for_each = {
    for key, value in var.cname : key => value
    if value.name != ""
  }
  name                = each.value["name"]
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_rg
  ttl                 = each.value["ttl"]
  record              = each.value["record"]
}

resource "azurerm_dns_txt_record" "record" {
  for_each = {
    for key, value in var.txt : key => value
    if value.name != ""
  }
  name                = each.value["name"]
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_rg
  ttl                 = each.value["ttl"]
  dynamic "record" {
    for_each = each.value["record"]
    content {
      value = record.value
    }
  }
}
