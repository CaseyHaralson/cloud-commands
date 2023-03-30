variable "project_id" {
  description = "The id of the project that should house the infrastructure"
  type        = string
  # default     = ""
}

variable "region" {
  description = "The region where the infrastructure should be created"
  type        = string
  # default     = ""
}

variable "network_name" {
  description = "The name of the vpc network"
  type        = string
  # default     = ""
}

variable "firewall_name" {
  description = "The name of the firewall"
  type        = string
  # default     = ""
}

variable "instances_zone" {
  description = "The zone where the instances should be created"
  type        = string
  # default     = ""
}