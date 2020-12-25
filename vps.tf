# https://jira.breadnet.co.uk/browse/CTOR-8
variable "key_pair" {
  type = map
  default = {
    public_key_path  = "/home/stannardb/.ssh/id_rsa.pub"
    private_key_path = "/home/stannardb/.ssh/id_rsa"
  }
}
# https://jira.breadnet.co.uk/browse/CTOR-8
resource "openstack_compute_keypair_v2" "desktop" {
  name = "desktop1"

  public_key = "${file("${var.key_pair["public_key_path"]}")}"
}
#Add firewall rules for inbound
# https://jira.breadnet.co.uk/browse/CTOR-7
resource "openstack_networking_secgroup_rule_v2" "" {
  direction = "Ingress"
  ethertype = ""
  security_group_id = ""
}

#https://jira.breadnet.co.uk/browse/CTOR-4
resource "openstack_compute_instance_v2" "torrentbox" {
  name        = "torrent-box"
  flavor_name = "s1-2"
  key_pair    = openstack_compute_keypair_v2.desktop.name
  image_name  = "Ubuntu 18.04"
  network {
    name = "Ext-Net"
  }
}

# Should remove but is being used for testing
resource "cloudflare_record" "torrent" {
  name    = "torrent"
  type    = "A"
  zone_id = var.zone_id
  proxied = "false"
  value   = openstack_compute_instance_v2.torrentbox.network[0].fixed_ip_v4
}

#output "fixed_ip_v4" {
#value = openstack_compute_instance_v2.torrentbox[count.index].network[0].fixed_ip_v4
#}
#output "tfid" {
# value = openstack_compute_instance_v2.torrentbox[count.index].id
#}