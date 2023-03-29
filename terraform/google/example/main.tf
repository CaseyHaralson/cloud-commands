provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  required_providers {
    google = {
      sousource = "hashicorp/google"
    }
  }
  backend "gcs" {
    bucket = var.bucket_name
    prefix = "terraform/state"
  }
}
