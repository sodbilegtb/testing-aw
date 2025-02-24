resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1b" {
  subnet_id      = aws_subnet.public_1b.id
  route_table_id = aws_route_table.public.id
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr_1b
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "public-subnet-1b"
  }
}

# Create public subnets
resource "aws_subnet" "public_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr_1a
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "public-subnet-1a"
  }
}

# Create private subnets
resource "aws_subnet" "private_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_1b # Add this variable in variables.tf
  availability_zone = "${var.aws_region}b"       # eu-central-1a
  tags = {
    Name = "private-subnet-1b"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_1a # Add this variable in variables.tf
  availability_zone = "${var.aws_region}a"       # eu-central-1a
  tags = {
    Name = "private-subnet-1a"
  }
}

# Create security group for EC2 instances
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id
  # Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22 # SSH (added later)
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows SSH from anywhere 
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web-sg"
  }
}



