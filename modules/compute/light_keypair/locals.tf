# commonly used expressions
locals {
  key_name = aws_lightsail_key_pair.main.name
  full_key_name = "${local.key_name}.pem"
}