# Example RDS Database
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    {
      Name        = "${var.environment}-db-subnet-group"
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_security_group" "db" {
  name        = "${var.environment}-db-sg"
  description = "Security group for ${var.environment} database"
  vpc_id      = var.vpc_id

  # Example ingress rule allowing connections from application instances
  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = var.app_security_group_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name        = "${var.environment}-db-sg"
      Environment = var.environment
    },
    var.tags
  )
}

resource "aws_db_instance" "main" {
  identifier           = "${var.environment}-db"
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.db_instance_type
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
  
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]
  
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  
  # Uncomment to enable encryption
  # storage_encrypted       = true
  # kms_key_id              = var.kms_key_id
  
  tags = merge(
    {
      Name        = "${var.environment}-db"
      Environment = var.environment
    },
    var.tags
  )
}