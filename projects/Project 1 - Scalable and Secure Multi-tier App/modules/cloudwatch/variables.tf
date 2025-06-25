variable "alarm_name" {
  description = "The name of the CloudWatch alarm."
  type        = string
}

variable "sns_topic_arn" {
  description = "The SNS topic ARN for alarm actions."
  type        = string
}

variable "asg_name" {
  description = "The name of the Auto Scaling Group to monitor."
  type        = string
}