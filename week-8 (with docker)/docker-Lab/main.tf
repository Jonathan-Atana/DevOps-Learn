# Configure the AWS Provider

provider "aws" {
  region = var.region
}

# Create a docker-lab VPC

resource "aws_vpc" "main" {

  cidr_block           = var.VPC_cidr
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  instance_tenancy     = "default"

  tags = {
    Name = "${var.project-name}-VPC"
  }

}

# Create an Internet Gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project-name}-igw"
  }
}

# Create a route table

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project-name}-public-route-table"
  }
}

# Associate the route table with the public subnet

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Create a public subnet

resource "aws_subnet" "main" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.AZ

  tags = {
    Name = "${var.project-name}-public-subnet"
  }
}

# Create Web Security Group

resource "aws_security_group" "main" {
  name        = "docker-Web-SG"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH traffic"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow app traffic"
    from_port   = 8000
    to_port     = 8100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project-name}-SG"
  }
}

# Generate a secure private key

resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create an AWS key pair

resource "aws_key_pair" "main" {
  key_name   = "${var.project-name}-keypair"
  public_key = tls_private_key.main.public_key_openssh
}

# Save private key to a local file

resource "local_file" "ssh_key" {
  filename        = "${path.root}/${aws_key_pair.main.key_name}.pem"
  content         = tls_private_key.main.private_key_pem
  file_permission = "400"
}

# Get the latest Amazon Linux 2 AMI

data "aws_ami" "amazon_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

# Create EC2 instance

resource "aws_instance" "DockerInstance" {
  ami                    = data.aws_ami.amazon_2.id
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = aws_key_pair.main.key_name
  user_data              = file("install.sh")

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "${var.project-name}-instance"
  }
}

# Outputs

output "ssh_command" {
  value = "ssh -i ${aws_key_pair.main.key_name}.pem ec2-user@${aws_instance.DockerInstance.public_dns}"
}

output "public_ip" {
  value = aws_instance.DockerInstance.public_ip
}
