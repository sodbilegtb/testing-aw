######################
# Local Variables
######################

locals {
  common_tags = {
    Project     = "AutomatedInfra"
    Environment = "Development"
    Owner       = "Sodbilegt"
  }
}


# Provider Configuration

provider "aws" {
  region = var.aws_region # Region specified in variables.tf
}

# Networking module: Creates VPC, subnets, and security groups

module "networking" {
  source                 = "./modules/networking"
  aws_region             = var.aws_region
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidr_1a  = var.public_subnet_cidr_1a
  public_subnet_cidr_1b  = var.public_subnet_cidr_1b
  private_subnet_cidr_1a = var.private_subnet_cidr_1a
  private_subnet_cidr_1b = var.private_subnet_cidr_1b
}

# Compute module: Creates EC2 instances with Nginx

module "compute" {
  source            = "./modules/compute"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.networking.public_subnet_ids[0] # Use the first public subnet
  security_group_id = module.networking.security_group_id
}

# RDS module: Creates PostgreSQL database

module "rds" {
  source            = "./modules/rds"
  db_instance_class = var.db_instance_class
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  subnet_ids        = module.networking.private_subnet_ids # Pass the list of private subnet IDs
  security_group_id = module.networking.security_group_id
}

module "static_website" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  common_tags = local.common_tags
  environment = local.common_tags["Environment"]
}