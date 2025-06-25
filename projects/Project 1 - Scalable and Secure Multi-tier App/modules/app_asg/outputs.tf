output "id" {
  description = "The ID of the launch template."
  value       = aws_launch_template.this.id
}

output "asg_name" {
  description = "The name of the Auto Scaling Group."
  value       = aws_autoscaling_group.this.name
}
