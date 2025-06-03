variable "project_prefix" {
  description = "Prefix to use for all my resources for easy identification"
  type        = string
  default     = "app"
}

variable "env" {
  description = "Environment for the resources, e.g., dev, staging, prod"
  type = string
  default = "dev"
}

variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "bucket" {
  description = "S3 bucket name for storing Terraform state"
  type        = string
}