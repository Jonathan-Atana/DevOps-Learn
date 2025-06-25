output "elb_dns_name" {
  description = "The DNS name of the ELB."
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "The ARN of the ALB target group."
  value       = aws_lb_target_group.app.arn
}
