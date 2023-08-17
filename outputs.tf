# output "vm_linux" {
#   value = {
#     name               = module.virtual_machine_linux.name
#     os_type            = module.virtual_machine_linux.os_type
#     os_image           = module.virtual_machine_linux.os_image
#     os_disk            = module.virtual_machine_linux.os_disk
#     data_disk          = module.virtual_machine_linux.data_disk
#     network_interfaces = module.virtual_machine_linux.network_interfaces
#     admin_username     = module.virtual_machine_linux.admin_username
#     ssh_public_key     = module.virtual_machine_linux.ssh_public_key
#     ssh_private_key    = module.virtual_machine_linux.ssh_private_key
#   }
#   sensitive = true

# }

# output "vm_windows" {
#   value = {
#     name               = module.virtual_machine_windows.name
#     os_type            = module.virtual_machine_windows.os_type
#     os_image           = module.virtual_machine_windows.os_type
#     os_disk            = module.virtual_machine_windows.os_disk
#     data_disk          = module.virtual_machine_windows.data_disk
#     network_interfaces = module.virtual_machine_windows.network_interfaces
#     admin_username     = module.virtual_machine_windows.admin_username
#     admin_password     = module.virtual_machine_windows.admin_password
#   }
#   sensitive = true
# }


# output "vnet_subnets" {
#   value = module.virtual_network.subnets
# }
