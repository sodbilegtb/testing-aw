variable "ami_id" {
  type = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.instance_type)
    error_message = "The instance type must be t2.micro or t3.micro (Free Tier eligible)."
  }
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}
variable "ec2_instance_count" {
  type    = number
  default = 1
}