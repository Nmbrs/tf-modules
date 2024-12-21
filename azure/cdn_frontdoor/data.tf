data "azurerm_dns_zone" "dns_zone" {
  for_each            = { for domain in local.custom_domains : lower(domain.fqdn) => domain }
  name                = each.value.dns_zone_name
  resource_group_name = each.value.dns_zone_resource_group_name
}
