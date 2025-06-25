variable "vpc_id" {
  description = "The VPC ID to associate with the security group."
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to the security group."
  type        = map(string)
  default     = null
}