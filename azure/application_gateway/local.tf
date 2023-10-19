# locals {
#   backend_address_pool_name = "${var.workload}-beap"
#   #frontend_port_name             = "${var.workload}-feport"
#   frontend_port_name = "frontendportname"
#   #frontend_ip_configuration_name = "${var.workload}-feip"
#   frontend_ip_configuration_name = "appgw-public-frontend-ip"
#   http_setting_name              = "${var.workload}-be-htst"
#   listener_name                  = "${var.workload}-httplstn"
#   request_routing_rule_name      = "${var.workload}-rqrt"
#   redirect_configuration_name    = "${var.workload}-rdrcfg"
# }


locals {
  backend_http_settings_name     = { for app in var.application_name : app.name => app.name }
  frontend_port_name             = { for app in var.application_name : app.name => app.name }
  frontend_ip_configuration_name = "frontendportname"
  http_setting_name              = { for app in var.application_name : app.name => app.name }
  listener_name                  = { for app in var.application_name : app.name => app.name }
  request_routing_rule_name      = { for app in var.application_name : app.name => app.name }
  redirect_configuration_name    = { for app in var.application_name : app.name => app.name }
}
