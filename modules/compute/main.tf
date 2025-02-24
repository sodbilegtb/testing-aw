# Fetch latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true             # Use the most recent AMI
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"] # AMI name pattern
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"] # Hardware Virtual Machine (HVM)
  }
}


# Create EC2 instances
resource "aws_instance" "web" {
  count                       = var.ec2_instance_count # Number of instances to create
  ami                         = data.aws_ami.ubuntu.id # Use the fetched AMI
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  security_groups             = [var.security_group_id] # Attach security group
  associate_public_ip_address = true                    # Assign a public IP
  tags = {
    Name = "web-instance"
  }
  # Root volume configuration
  root_block_device {
    volume_size           = 10    # Size in GB
    volume_type           = "gp2" # General Purpose SSD
    delete_on_termination = true
  }

  # User data script to install Nginx
  user_data = <<-EOF
            #!/bin/bash
            apt-get update -y
            apt-get install -y nginx
            systemctl start nginx
            systemctl enable nginx
            echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
            EOF

}

