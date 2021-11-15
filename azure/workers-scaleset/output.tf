output "subnet_id" {
    value = data.azurerm_subnet.scaleset.id
}

output "random_password" {
    value = random_password.scaleset.result
    sensitive = true
}