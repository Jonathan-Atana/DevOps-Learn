variable "filter_names" {
  description = "List of names to use for filtering AMIs in the data source block"
  type = list(string)
  default = [ "amzn2-ami-hvm-*-x86_64-gp2" ]  # default filter name for Amazon Linux 2 AMI
}

variable "instance_type" {
  description = "Instance type to use for the AWS instance resource"
  type = string
  default = "t2.micro"
}

variable "file_path" {
  description = "Path to the creation of the private key pair"
  type = string
  default = "locals"
}

variable "user_data" {
  description = "User data to use for the AWS instance resource"
  type = string
  default = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > /var/www/html/index.html
              EOF
  
}

variable "tags" {
  description = "Tags in the AWS instance resource"
  type = map(string)
  default = {
    Name = "server"
    env = null
    Team = "DevOps"
  }
}