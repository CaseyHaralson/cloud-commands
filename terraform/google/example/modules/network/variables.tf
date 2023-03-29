variable "project_id" {
  description = "The id of the project that should house the infrastructure"
  type        = string
  # default     = ""
}

variable "network_name" {
  description = "The name of the vpc network"
  type        = string
  # default     = ""
}

# variable "subnetwork1_name" {
#   description = "The 1st subnet's name"
#   type        = string
#   # default     = ""
# }

# variable "subnetwork2_name" {
#   description = "The 2nd subnet's name"
#   type        = string
#   # default     = ""
# }

variable "subnet_region" {
  description = "The region where the subnets should be created"
  type        = string
  # default     = ""
}

variable "firewall_name" {
  description = "The name of the firewall"
  type        = string
  # default     = ""
}