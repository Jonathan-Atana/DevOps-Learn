variable "server_name" {
  description = "The name of the Lightsail instance."
  type        = string
  default = "server"
}

variable "availability_zone" {
  description = "The availability zone for the Lightsail instance."
  type        = string
  default     = "us-east-1a"
}

variable "blueprint_id" {
  description = "The blueprint ID for the Lightsail instance."
  type        = string
  default     = "centos_stream_9"
}

variable "bundle_id" {
  description = "The bundle ID for the Lightsail instance."
  type        = string
  default     = "nano_3_0"
}

variable "file_path" {
  description = "Path to the creation of the private key pair"
  type = string
  default = "locals"
}

variable "user_data" {
  description = "User data to use for the Lightsail resource"
  type = string
  default = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > /var/www/html/index.html
              EOF
  
}

variable "tags" {
  description = "A map of tags to assign to the Lightsail instance."
  type        = map(string)
  default     = {
    env  = null
    Team = "DevOps"
  }
}