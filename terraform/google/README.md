# Terraform - Google Example

This example creates a Cloud Storage bucket to hold the Terraform state. It then creates a VPC network with two subnets, a firewall rule to allow traffic on port 80, and two VM instances (one on each subnet).

## Create GCS Backend

1. Navigate to the "gcs_backend" folder and run `terraform init`
2. Run `terraform apply` to create a storage bucket to hold the state for the example

## Create Example Infrastructure

1. Navigate to the "example" folder
2. Edit the "main.tf" file and insert the newly created gcs_backend bucket name in the "terraform.backend.gcs.bucket" value
3. Run `terraform init`
4. Run `terraform apply`
