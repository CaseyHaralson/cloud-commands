module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "6.0.0"

  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "subnet-01",
      subnet_ip     = "10.10.10.0/24",
      subnet_region = var.subnet_region
    },
    {
      subnet_name   = "subnet-02",
      subnet_ip     = "10.10.20.0/24",
      subnet_region = var.subnet_region
    }
  ]
}

resource "google_compute_firewall" "this" {
  name    = var.firewall_name
  network = "${module.vpc.network_name}"

  allow {
    protocol = "tcp"
    ports    = [ "80" ]
  }

  source_ranges = [ "0.0.0.0/0" ]
}