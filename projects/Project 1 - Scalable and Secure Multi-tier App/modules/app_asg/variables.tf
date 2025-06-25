variable "name" {
  description = "Name of the Auto Scaling Group."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for the launch template name."
  type        = string
}

variable "ami" {
  description = "AMI ID for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs."
  type        = list(string)
}

variable "max_size" {
  description = "Maximum size of the ASG."
  type        = number
}

variable "min_size" {
  description = "Minimum size of the ASG."
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity of the ASG."
  type        = number
}

variable "vpc_zone_identifier" {
  description = "List of subnet IDs for the ASG."
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "The name of the IAM instance profile to attach to EC2 instances."
  type        = string
  default     = null
}

variable "target_group_arns" {
  description = "List of target group ARNs to associate with the ASG."
  type        = list(string)
  default     = []
}

variable "app_port" {
  description = "Port on which the application is running."
  type        = number
}
