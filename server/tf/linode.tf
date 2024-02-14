resource "linode_instance" "mih" {
    region = "se-sto"
    type = "g6-standard-1"
    image = "linode/ubuntu22.04"
    label = "MiH-Site"
    authorized_keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICC3CYVUHuEGKnyQ5wBfAx4MVHyZYp+MUQlv4MKzZmf3 dan@matrix" ]
}

resource "ansible_host" "host" {
    name = linode_instance.mih.ip_address
}
