variable "key_name" {
  description = "Name of the lightsail instance key pair"
  type = string
  default = "light-key"
}

variable "rsa_bits" {
  description = "RSA encryption bits size"
  type = number
  default = 4098
}

variable "file_path" {
  description = "Path to the creation of the private key pair"
  type = string
  default = "locals"
}