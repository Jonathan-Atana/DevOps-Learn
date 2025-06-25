variable "subnet_ids" {
  description = "List of subnet IDs for the ELB."
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID for the ELB."
  type        = string
}

variable "namespace" {
  description = "Namespace for the ELB."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the target group."
  type        = string
}

variable "app_port" {
  description = "Port on which the application is running."
  type        = number
}
