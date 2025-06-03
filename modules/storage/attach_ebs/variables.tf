variable "device_name" {
  description = "The device name to expose to the instance (e.g. /dev/xvdf)"
  type        = string
  default = "/dev/sdh"
}

variable "instance_id" {
  description = "The ID of the EC2 instance to attach the volume to"
  type        = string
}

variable "volume_size" {
  description = "Size of the EBS volume in GB"
  type = number
  default = 10
}

variable "az" {
  description = "Availability zone for the EBS volume"
  type = string
  default = "us-east-1a"
}

variable "tags" {
  description = "Tags to use"
  type = map(string)
  default = {
    name = "example-volume"
  }
}
