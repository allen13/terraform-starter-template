output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.main.id
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.main.address
}

output "db_instance_endpoint" {
  description = "The connection endpoint of the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_status" {
  description = "The status of the RDS instance"
  value       = aws_db_instance.main.status
}

output "db_subnet_group_id" {
  description = "The ID of the DB subnet group"
  value       = aws_db_subnet_group.main.id
}

output "db_security_group_id" {
  description = "The ID of the security group associated with the RDS instance"
  value       = aws_security_group.db.id
}

output "db_endpoint" {
  description = "The connection endpoint of the RDS instance"
  value       = aws_db_instance.main.endpoint
}