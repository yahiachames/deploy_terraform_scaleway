resource "scaleway_vpc_private_network" "chameseddine_pnc" {
  name = "chameseddine_pn"
   project_id = var.project_id

}
resource "scaleway_vpc_public_gateway" "chameseddine_gateway" {
  name = "chameseddine_gateway"
  type = "VPC-GW-S"
  ip_id = scaleway_vpc_public_gateway_ip.gw01.id
   project_id = var.project_id
}
resource "scaleway_vpc_public_gateway_ip" "gw01" {
    project_id = var.project_id
}

resource "scaleway_vpc_public_gateway_dhcp" "dhcp01" {
  subnet = "192.168.1.0/24"
  push_default_route = true
  project_id = var.project_id
  pool_low = "192.168.1.2"
  pool_high = "192.168.1.3"
}
resource "scaleway_vpc_gateway_network" "main" {
  gateway_id = scaleway_vpc_public_gateway.chameseddine_gateway.id
  private_network_id = scaleway_vpc_private_network.chameseddine_pnc.id
  dhcp_id = scaleway_vpc_public_gateway_dhcp.dhcp01.id
  cleanup_dhcp       = true
  enable_masquerade  = true
}

resource scaleway_vpc_public_gateway_dhcp_reservation main {
    gateway_network_id = scaleway_vpc_gateway_network.main.id
    mac_address = scaleway_instance_server.server_chameseddine.private_network.0.mac_address
    ip_address = "192.168.1.7"
}

# forwarding rules

resource "scaleway_vpc_public_gateway_pat_rule" "main" {
  gateway_id = scaleway_vpc_public_gateway.chameseddine_gateway.id
  private_ip = scaleway_vpc_public_gateway_dhcp_reservation.main.ip_address
  private_port = 22
  public_port = 2221
  protocol = "both"
  depends_on = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
}