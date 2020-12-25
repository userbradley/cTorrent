# https://jira.breadnet.co.uk/browse/CTOR-8
resource "openstack_compute_keypair_v2" "key" {
  name       = "SSH"
  public_key = file(var.pub_file_location)
}

# https://jira.breadnet.co.uk/browse/CTOR-7
resource "openstack_networking_secgroup_v2" "inbound" {
  name        = "inbound"
  description = "Inbound rules"
}

# https://jira.breadnet.co.uk/browse/CTOR-7
resource "openstack_networking_secgroup_rule_v2" "inbound_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = var.ip
  port_range_min    = 22
  port_range_max    = 22
  security_group_id = openstack_networking_secgroup_v2.inbound.id
}

# https://jira.breadnet.co.uk/browse/CTOR-7
resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction = "ingress"
  ethertype = "IPv4"
  remote_ip_prefix = var.ip
  protocol = "icmp"
  security_group_id = openstack_networking_secgroup_v2.inbound.id
}

# https://jira.breadnet.co.uk/browse/CTOR-4
resource "openstack_compute_instance_v2" "torrentbox" {
  name            = "torrent-box"
  flavor_name     = "s1-2"
  key_pair        = openstack_compute_keypair_v2.key.name
  image_name      = "Ubuntu 18.04"
  security_groups = [openstack_networking_secgroup_v2.inbound.id]
  network {
    name = "Ext-Net"
  }
}