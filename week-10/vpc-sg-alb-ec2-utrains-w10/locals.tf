locals {
  user_data = file("${path.root}/setup.sh")
  ec2_sg_id = aws_security_group.sg1.id
  http_protocol = "HTTP"
}