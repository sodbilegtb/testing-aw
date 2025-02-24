variable "db_instance_class" {
  type = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true # Hide password in logs

  validation {
    condition = (
      length(regexall("[a-zA-Z]+", var.db_password)) > 0            # At least 1 letter
      && length(regexall("[0-9]+", var.db_password)) > 0            # At least 1 digit
      && length(regexall("^[a-zA-Z0-9]{6,}$", var.db_password)) > 0 # Min 6 characters
    )
    error_message = <<-EOT
    Password must comply following format:
    1. Contain at least 1 character
    2. Contain at least 1 digit 
    3. Be at least 6 character long
    EOT
  }
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}