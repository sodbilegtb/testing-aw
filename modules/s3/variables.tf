variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "environment" {
  description = "Deployment environment (e.g., Development, Production)"
  type        = string
}