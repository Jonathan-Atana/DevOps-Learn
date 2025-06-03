# locals for expressions used ofted
locals {
  public_ip = aws_lightsail_instance.main.public_ip_address
}

output "public-ip" {
  description = "The public ip of the server"
  value = local.public_ip
}

output "ssh-command" {
  description = "Command to remotely connect to the lightsail instance via ssh"
  value = "ssh -i ${module.keypair.key-name}.pem ec2-user@${local.public_ip}"
}