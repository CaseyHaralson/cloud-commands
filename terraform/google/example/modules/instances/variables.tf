variable "zone" {
  description = "The zone where the instances should be created"
  type        = string
  # default     = ""
}

variable "network" {
  description = "The network where the instances should be attached"
  type        = string
  # default     = ""
}

variable "subnetwork1" {
  description = "The subnetwork where the first instance should be attached"
  type        = string
  # default     = ""
}

variable "subnetwork2" {
  description = "The subnetwork where the second instance should be attached"
  type        = string
  # default     = ""
}