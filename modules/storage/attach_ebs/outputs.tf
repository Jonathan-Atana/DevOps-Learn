output "attachment_id" {
  description = "The ID of the volume attachment"
  value       = aws_volume_attachment.main.id
}

output "volume_id" {
  description = "ID of the created EBS volume"
  value = aws_ebs_volume.main.id
}
