terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
#  required_version = ">= 0.13"
}

provider "scaleway" {
   access_key      = var.access_key
    secret_key      = var.secret_key
  zone   = "fr-par-1"
  region = "fr-par"
}

