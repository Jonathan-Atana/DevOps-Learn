variable "http_port" {
  description = "Default port for http traffic"
  type = number
  default = 80
}

variable "https_port" {
  description = "Default port for https traffic"
  type = number
  default = 443
}

variable "env" {
  description = "Project Environment"
  type = string
  default = "Dev"
}

variable "package_manager" {
  description = "Package manager used for user data"
  type = string
}

variable "instance_type" {
  description = "Type of EC2 instance to launch"
  type        = string
}

variable "aws_ami_names" {
  description = "List of names of the AWS AMI to use"
  type        = list(string)
}

variable "region" {
  description = "Region to deploy infrastructure"
  type = string
  default = "us-east-1"
}

variable "bucket" {
  description = "AWS S3 bucket name"
  type = string
}