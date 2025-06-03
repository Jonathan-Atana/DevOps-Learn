variable "key_name" {
  description = "Name of the EC2 key pair to create"
  type = string
  default = "ec2-key"
}

variable "rsa_bits" {
  description = "Key encryption size in bits"
  type = number
  default = 2048
}

variable "file_permission" {
  description = "File permission for the private key file"
  type = number
  default = 0400
}

variable "file_path" {
  description = "Path to the creation of the private key pair"
  type = string
  default = "locals"
}