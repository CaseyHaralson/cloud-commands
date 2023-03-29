resource "google_compute_instance" "server1" {
  name         = "server1"
  machine_type = "n1-standard-1"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork1
  } 

  metadata_startup_script   = "#!/bin/bash"
  allow_stopping_for_update = true
}

resource "google_compute_instance" "server2" {
  name         = "server2"
  machine_type = "n1-standard-1"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork2
  } 

  metadata_startup_script   = "#!/bin/bash"
  allow_stopping_for_update = true
}