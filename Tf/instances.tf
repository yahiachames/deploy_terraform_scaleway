
resource "scaleway_instance_server" "server_chameseddine" {
  image = "ubuntu_jammy"
  type  = "DEV1-S"
  zone = scaleway_vpc_private_network.chameseddine_pnc.zone
  project_id = var.project_id
  name="chameseddine_server"
    private_network {
        pn_id = scaleway_vpc_private_network.chameseddine_pnc.id
    }
}






