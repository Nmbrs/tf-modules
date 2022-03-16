data "azurerm_dns_zone" "record" {
  name                = var.dns_zone
  resource_group_name = "rg-dnszones"
}

resource "azurerm_dns_a_record" "record" {
  for_each = {
    for key, value in var.a : key => value
    if value.a != ""
  }
  name                = each.value["a"]
  zone_name           = data.azurerm_dns_zone.record.name
  resource_group_name = data.azurerm_dns_zone.record.resource_group_name
  ttl                 = 300
  records             = each.value["records"]
}

resource "azurerm_dns_cname_record" "record" {
  for_each = {
    for key, value in var.cname : key => value
    if value.cname != ""
  }
  name                = each.value["cname"]
  zone_name           = data.azurerm_dns_zone.record.name
  resource_group_name = data.azurerm_dns_zone.record.resource_group_name
  ttl                 = 300
  record              = "${each.value["record"]}.azurewebsites.net"
}

resource "azurerm_dns_txt_record" "record" {
  for_each = {
    for key, value in var.txt : key => value
    if value.txt != ""
  }
  name                = each.value["txt"]
  zone_name           = data.azurerm_dns_zone.record.name
  resource_group_name = data.azurerm_dns_zone.record.resource_group_name
  ttl                 = 300
  dynamic "record" {
    for_each = each.value["record"]
    content {
      value = record.value
    }
  }
}
