resource "aws_db_instance" "default" {
  allocated_storage      = 20                    # Storage in GB
  engine                 = "postgres"            # Database engine
  engine_version         = "15.10"               # PostgreSQL version
  instance_class         = var.db_instance_class # DB instance type
  db_name                = var.db_name           # Correct attribute for the database name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.postgres15" # Parameter group for PostgreSQL 15
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.security_group_id]          # Attach security group
  db_subnet_group_name   = aws_db_subnet_group.default.name # Use the subnet group
}

resource "aws_db_subnet_group" "default" {
  subnet_ids = var.subnet_ids
  tags = {
    Name = "rds-subnet-group"
  }
}