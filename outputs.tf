######################
# Output Values
######################

output "ec2_public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = module.compute.ec2_public_ips # Outputs EC2 instance public IPs
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.rds_endpoint # Outputs RDS database endpoint
}