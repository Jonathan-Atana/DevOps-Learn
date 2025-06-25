resource "aws_cloudwatch_metric_alarm" "asg_high_cpu" {
  alarm_description = "This metric monitors high average CPU utilization for the ASG"
  alarm_name        = "asg-${var.alarm_name}"
  namespace         = "AWS/AutoScaling"

  metric_name         = "GroupAverageCPUUtilization"
  statistic           = "Average"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 80

  evaluation_periods = 2
  period             = 180

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  alarm_actions = [var.sns_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "ec2_high_cpu" {
  alarm_description = "This metric monitors high average CPU utilization for EC2 instances in an ASG"
  alarm_name        = "ec2-fleet-${var.alarm_name}"
  namespace         = "AWS/EC2"

  metric_name         = "CPUUtilization"
  statistic           = "Average"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 80

  evaluation_periods = 2
  period             = 120

  dimensions = { AutoScalingGroupName = var.asg_name }

  alarm_actions = [var.sns_topic_arn]
}