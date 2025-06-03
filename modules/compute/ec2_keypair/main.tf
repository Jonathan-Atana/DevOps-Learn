# Generate a new RSA key
resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

# public key in aws
resource "aws_key_pair" "main" {
  key_name = var.key_name
  public_key = tls_private_key.main.public_key_openssh
}

# download private key
resource "local_file" "main" {
  filename = "${var.file_path}/${local.full_key_name}"
  content = tls_private_key.main.private_key_pem
  file_permission = var.file_permission
}