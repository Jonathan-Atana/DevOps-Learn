locals {
  public_ip = aws_instance.main.public_ip
}

output "public-ip" {
  description = "Public IP address of the EC2 instance"
  value       = local.public_ip
}

output "ssh-command" {
  description = "SSH command to connect to the EC2 instance"
  value       = "ssh -i ${module.keypair.key-name}.pem ec2-user@${local.public_ip}"
}

output "instance-id" {
  description = "Instance ID of the EC2 instance"
  value = aws_instance.main.id
  sensitive = true
}