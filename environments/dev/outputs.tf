output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.networking.vpc_id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = module.networking.subnet_ids
}

output "instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = module.compute.instance_ids
}

output "db_endpoint" {
  description = "The endpoint of the database"
  value       = module.database.db_endpoint
}