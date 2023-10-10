locals {
  backend_address_pool_name      = "${var.application_name}-beap"
  frontend_port_name             = "${var.application_name}-feport"
  frontend_ip_configuration_name = "${var.application_name}-feip"
  http_setting_name              = "${var.application_name}-be-htst"
  listener_name                  = "${var.application_name}-httplstn"
  request_routing_rule_name      = "${var.application_name}-rqrt"
  redirect_configuration_name    = "${var.application_name}-rdrcfg"
}