variable "vpc_id" {
  description = "The VPC ID to associate with the endpoint."
  type        = string
}

variable "route_table_ids" {
  description = "List of route table IDs for the endpoint."
  type        = list(string)
}

variable "aws_region" {
  description = "The AWS region for the S3 endpoint."
  type        = string
}
