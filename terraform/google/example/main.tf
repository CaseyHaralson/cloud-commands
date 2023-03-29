provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
  backend "gcs" {
    bucket = "" # this needs to be filled out manually
    prefix = "terraform/state"
  }
}

module "network" {
  source = "./modules/network"

  project_id    = var.project_id
  network_name  = var.network_name
  subnet_region = var.region
  firewall_name = var.firewall_name
}

module "instances" {
  source = "./modules/instances"

  zone        = var.instances_zone
  network     = "${module.network.network_name}"
  subnetwork1 = "${module.network.subnets_names[0]}"
  subnetwork2 = "${module.network.subnets_names[1]}"
}