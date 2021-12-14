output "public_ip_address" {
  value = data.azurerm_public_ip.natgw.ip_address
}
