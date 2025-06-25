output "asg_alarm_arn" {
  description = "The ARN of the CloudWatch ASG alarm."
  value       = aws_cloudwatch_metric_alarm.asg_high_cpu.arn
}

output "ec2_alarm_arn" {
  description = "The ARN of the CloudWatch EC2 alarm."
  value       = aws_cloudwatch_metric_alarm.ec2_high_cpu.arn
}