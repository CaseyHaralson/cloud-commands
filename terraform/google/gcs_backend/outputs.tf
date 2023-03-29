output "backend_bucket_name" {
  description = "The name of the backend bucket"
  value       = google_storage_bucket.this.name
}