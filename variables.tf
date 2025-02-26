# AWS region (default: eu-central-1)
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_1a" {
  description = "CIDR block for the public subnet in AZ 1a"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_1b" {
  description = "CIDR block for the public subnet in AZ 1b"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_1a" {
  description = "CIDR block for the private subnet in AZ 1a"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_cidr_1b" {
  description = "CIDR block for the private subnet in AZ 1b"
  type        = string
  default     = "10.0.4.0/24"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 (Free Tier eligible)
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro" # Free Tier eligible
}

variable "db_instance_class" {
  description = "Instance class for the RDS instance"
  type        = string
  default     = "db.t2.micro" # Free Tier eligible
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true # Marks this variable as sensitive
}


variable "bucket_name" {
  description = "Name of the S3 bucket for static website"
  type        = string
}