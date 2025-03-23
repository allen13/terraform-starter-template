output "instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = aws_instance.app[*].id
}

output "instance_public_ips" {
  description = "The public IP addresses of the EC2 instances"
  value       = aws_instance.app[*].public_ip
}

output "instance_private_ips" {
  description = "The private IP addresses of the EC2 instances"
  value       = aws_instance.app[*].private_ip
}