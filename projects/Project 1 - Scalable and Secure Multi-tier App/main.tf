# Root Terraform configuration for Project 1 - Scalable and Secure Multi-tier App

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.99.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.env
      Terraform   = "true"
      Owner       = "DevTeam"
    }
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "project1-vpc"

  cidr = "10.0.0.0/16"
  azs  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets = [
    "10.0.1.0/24", # public-a (us-east-1a)
    "10.0.3.0/24", # public-b (us-east-1b)
    "10.0.5.0/24"  # public-c (us-east-1c)
  ]
  private_subnets = [
    "10.0.2.0/24",  # private-a1 (us-east-1a)
    "10.0.4.0/24",  # private-a2 (us-east-1a)
    "10.0.6.0/24",  # private-b1 (us-east-1b)
    "10.0.8.0/24",  # private-b2 (us-east-1b)
    "10.0.10.0/24", # private-c1 (us-east-1c)
    "10.0.12.0/24"  # private-c2 (us-east-1c)
  ]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# Bastion Host in public subnet (AZ c)
module "bastion_sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["102.244.197.146/32"] # Listen only from my IP
  }]

  egress_rules = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]

  tags = {
    Name = "${var.namespace}-bastion-sg"
  }
}

module "bastion" {
  source = "./modules/ec2"

  subnet_id         = module.vpc.public_subnets[2] # 1c
  security_group_id = module.bastion_sg.security_group_id

  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
}

# ALB Security Group
module "alb_sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]

  tags = {
    Name = "${var.namespace}-alb-sg"
  }
}

# App Security Group (only allow traffic from ALB SG)
module "app_sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [{
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [module.alb_sg.security_group_id]
    cidr_blocks     = []
  }]

  egress_rules = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]

  tags = {
    Name = "${var.namespace}-app-sg"
  }
}

# Database Security Group (only allow traffic from App SG)
module "db_sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [{
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.app_sg.security_group_id]
    cidr_blocks     = []
  }]

  egress_rules = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]

  tags = {
    Name = "${var.namespace}-db-sg"
  }
}

# --- App Launch Template + Auto Scaling Group (combined module) ---
module "app_asg" {
  source      = "./modules/app_asg"
  name        = "${var.namespace}-asg"
  name_prefix = "${var.namespace}-launch-template-"
  app_port    = var.app_port

  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"

  max_size         = 3
  min_size         = 1
  desired_capacity = 2

  security_group_ids = [module.app_sg.security_group_id]
  vpc_zone_identifier = [
    module.vpc.private_subnets[0], # 1a
    module.vpc.private_subnets[2]  # 1b
  ]

  iam_instance_profile = module.ec2_s3_iam_role.instance_profile_name
  target_group_arns    = [module.elb.target_group_arn]
}

# RDS Multi-AZ
module "rds" {
  source    = "./modules/rds"
  namespace = var.namespace

  username = "admin"
  password = "changeme123"

  subnet_id = null # not used, but required by module interface
  subnet_group_subnet_ids = [
    module.vpc.private_subnets[0], # 1a
    module.vpc.private_subnets[2]  # 1b
  ]
  security_group_id = module.db_sg.security_group_id
}

# ALB across 1st 2 public subnets
module "elb" {
  source    = "./modules/elb"
  namespace = var.namespace

  security_group_id = module.alb_sg.security_group_id
  vpc_id            = module.vpc.vpc_id
  app_port          = var.app_port

  subnet_ids = [
    module.vpc.public_subnets[0], # 1a
    module.vpc.public_subnets[1]  # 1b
  ]
}

# VPC Endpoint for S3 (all route tables)
module "vpc_endpoint_s3" {
  source = "./modules/vpc_endpoint"

  vpc_id          = module.vpc.vpc_id
  aws_region      = var.aws_region
  route_table_ids = module.vpc.private_route_table_ids
}

module "sns_alerts" {
  source = "./modules/sns"

  topic_name = "project1-alerts"
  email      = "your-email@example.com" # Change to your email
}

module "cloudwatch_ec2_high_cpu" {
  source = "./modules/cloudwatch"

  alarm_name    = "HighCPUUtilization"
  asg_name      = module.app_asg.asg_name
  sns_topic_arn = module.sns_alerts.topic_arn
}

module "s3_bucket" {
  source = "./modules/s3"

  bucket_name   = var.bucket_name
  force_destroy = true
  vpce_id       = module.vpc_endpoint_s3.vpc_endpoint_id
}

module "ec2_s3_iam_role" {
  source = "./modules/iam_role"

  role_name   = "${var.namespace}-ec2-s3-access"
  bucket_arn  = module.s3_bucket.bucket_arn
  bucket_name = module.s3_bucket.bucket_name
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
