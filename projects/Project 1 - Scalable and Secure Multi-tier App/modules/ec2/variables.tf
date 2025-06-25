variable "subnet_id" {
  description = "The subnet ID to launch the instance in."
  type        = string
}

variable "security_group_id" {
  description = "The security group ID to associate with the instance."
  type        = string
}

variable "ami" {
  description = "The AMI to use for the instance."
  type        = string
}

variable "instance_type" {
  description = "The instance type."
  type        = string
}

variable "namespace" {
  description = "A prefix or namespace to apply to the instance name."
  type        = string
  default     = "bastion"
}
