# commonly used expressions
locals {
  key_name = aws_key_pair.main.key_name
  full_key_name = "${local.key_name}.pem"
}