# Create an EBS volume
resource "aws_ebs_volume" "main" {
  availability_zone = var.az
  size            = var.volume_size

  tags = var.tags
}

# Attach EBS volume to an EC2 instance
resource "aws_volume_attachment" "main" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.main.id
  instance_id = var.instance_id
}
