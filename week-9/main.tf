provider "aws" {
  region = "us-east-1"
}

# create key pair
resource "tls_private_key" "tls_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# add public key to lightsail
resource "aws_lightsail_key_pair" "lkey" {
  name       = "week-9"
  public_key = tls_private_key.tls_private_key.public_key_openssh
}

# Download private key
resource "local_file" "file" {
  file_permission = 0400
  filename        = "week9.pem"
  content         = tls_private_key.tls_private_key.private_key_pem
}

# lightsail instance
resource "aws_lightsail_instance" "server" {
  name              = "lamp-server"
  availability_zone = "us-east-1a"
  blueprint_id      = "centos_stream_9"
  bundle_id         = "small_2_0"
  key_pair_name     = aws_lightsail_key_pair.lkey.name

  depends_on = [aws_lightsail_key_pair.lkey]

  tags = {
    env  = "dev"
    Team = "DevOps"
  }
}

# some outputs
output "public-ip" {
  description = "Public IP address of the lightsail server"
  value       = aws_lightsail_instance.server.public_ip_address
}

output "ssh-command" {
  description = "Command to remotely login to server"
  value       = "ssh -i week-9.pem ec2-user@${aws_lightsail_instance.server.public_ip_address}"
}