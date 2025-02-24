output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [aws_subnet.public_1a.id, aws_subnet.public_1b.id] # List of public subnet IDs
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = [aws_subnet.private_1a.id, aws_subnet.private_1b.id] # List of private subnet IDs
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web.id
}