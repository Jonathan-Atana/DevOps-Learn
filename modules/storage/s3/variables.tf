variable "region_name" {
  description = "Region where you want the bucket"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of bucket on s3"
  type        = string
}