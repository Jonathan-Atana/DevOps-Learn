variable "subnet_id" {
  description = "The subnet ID for the RDS instance."
  type        = string
}

variable "security_group_id" {
  description = "The security group ID for the RDS instance."
  type        = string
}

variable "username" {
  description = "Master username."
  type        = string
}

variable "password" {
  description = "Master password."
  type        = string
  sensitive   = true
}

variable "subnet_group_subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group (Multi-AZ)."
  type        = list(string)
  default     = null
}

variable "namespace" {
  description = "Namespace for the RDS instance, used in naming."
  type        = string
}