variable "project_id" {
  description = "The id of the project that should store the backend state"
  type        = string
  default     = ""
}

variable "region" {
  description = "The region where the bucket should be stored"
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "The name of the backend storage bucket"
  type        = string
  default     = ""
}

