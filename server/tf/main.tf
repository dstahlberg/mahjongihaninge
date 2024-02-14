terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "2.5.2"
    }
    ansible = {
      version = "~> 1.1.0"
      source  = "ansible/ansible"
    }
  }
}

variable "mih_token" {}


provider "linode" {
  token = var.mih_token
}
