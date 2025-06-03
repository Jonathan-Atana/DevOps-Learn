# EC2 outputs
output "public-ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2.public-ip
}

output "ssh-command" {
  description = "SSH command to connect to the EC2 instance"
  value       = module.ec2.ssh-command
}
/* 
# Lightsail outputs
output "public-ip" {
  description = "The public ip of the lightsail server"
  value = module.lightsail.public-ip
}

output "ssh-command" {
  description = "Command to remotely connect to the lightsail instance via ssh"
  value = module.lightsail.ssh-command
}

# S3 bucket outputs
output "bucket-name" {
  description = "Name of the S3 bucket"
  value       = module.s3.bucket-name
} */