data "aws_ami" "main" { # get the latest specified ami
  most_recent = true
  owners      = ["amazon"] # Amazon's official AMIs

  filter {
    name   = "name"
    values = var.aws_ami_names
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "server" {
  count = 2  # Create two instances
  instance_type          = var.instance_type
  ami                    = data.aws_ami.main.id # Use the latest AMI from the data source
  user_data              = local.user_data
  subnet_id              = module.vpc.private_subnets[count.index] # Use the first public subnet from the VPC module
  vpc_security_group_ids = [local.ec2_sg_id]

  tags = {
    Name = "Webserver-${count.index + 1}"
    env  = var.env
  }
}