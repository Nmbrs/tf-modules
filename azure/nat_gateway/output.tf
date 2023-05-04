output "public_ip_address" {
  value = azurerm_public_ip.natgw.ip_address
  description = "Output of the public IP"
}
