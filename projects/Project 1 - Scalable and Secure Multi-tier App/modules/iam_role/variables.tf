variable "role_name" {
  description = "Name of the IAM role."
  type        = string
}

variable "bucket_arn" {
  description = "ARN of the S3 bucket to allow access."
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket to allow access."
  type        = string
}
