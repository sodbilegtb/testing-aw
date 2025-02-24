output "ec2_public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = aws_instance.web[*].public_ip # Output all EC2 public IPs
}