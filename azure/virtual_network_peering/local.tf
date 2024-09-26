locals {
  source_peering_name      = "${var.vnet_source.name}-to-${var.vnet_destination.name}"
  destination_peering_name = "${var.vnet_destination.name}-to-${var.vnet_source.name}"
}
