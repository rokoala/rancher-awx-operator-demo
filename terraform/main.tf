terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}
variable "qty_machine" {}
variable "ssh_pub_key" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "default" {
  name       = "Digital Ocean SSH"
  public_key = file(var.ssh_pub_key)
}

resource "digitalocean_droplet" "labs" {
  image    = "ubuntu-22-10-x64"
  name     = "labs-${count.index + 1}"
  region   = "nyc3"
  size     = "s-4vcpu-8gb"
  count    = var.qty_machine
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}
