variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "The type of environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "namespace" {
  description = "A prefix or namespace to apply to all resources."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
  sensitive   = true
}

variable "app_port" {
  description = "The port on which the application will run."
  type        = number
}

# Add more variables as needed for modules
