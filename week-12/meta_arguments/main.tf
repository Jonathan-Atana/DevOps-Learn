provider "aws" {
  region = "us-east-1"
}

/* resource "aws_instance" "main" {
  count = 3
  ami = "ami-0e58b56aa4d64231b"
  instance_type = "t2.micro"

  tags = {
    Name = "dev-${count.index}"
  }
} */

variable "instance_types" {
  description = "Types for instances"
  type = set(string)
  default = [ "t2.micro", "t3.small" ]
}

resource "aws_instance" "main" {
  for_each = var.instance_types

  ami = "ami-0e58b56aa4d64231b"
  instance_type = each.key

  lifecycle {
    create_before_destroy = true
  }
}