output "network_name" {
  description = "The name of the network"
  value       = "${module.vpc.network_name}"
}

output "subnets_names" {
  description = "The names of the subnets"
  value       = module.vpc.subnets_names
}