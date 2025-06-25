provider "aws" {
  region = var.region
}

/*
module "s3" {
  source = ".github.com/Jonathan-Atana/terraform-modules/storage/s3?ref=v1.0.0"

  bucket_name = var.bucket
  region_name = var.region
}

module "lightsail" {  # Create a Lightsail instance
  source = ".github.com/Jonathan-Atana/terraform-modules/compute/lightsail?ref=v1.0.0"

  server_name = "${var.project_prefix}-${var.env}-server"

  tags = {
    env = var.env
  }
}
*/

module "ec2" { # create an EC2 instance
  source = ".github.com/Jonathan-Atana/terraform-modules/compute/ec2?ref=v1.0.0"

  file_path       = "${path.root}/vars"

  tags = {
    env  = var.env
    Name = "${var.project_prefix}-${var.env}-server"
  }
}

/* module "attach_ebs" {
  source = ".github.com/Jonathan-Atana/terraform-modules/storage/attach_ebs?ref=v1.0.0"

  device_name = "/${var.env}/xvdf"
  az          = "${var.region}a"
  volume_size = 10
  instance_id = module.ec2.instance-id

  tags = {
    Name = "${var.env}-MyEBSVolume"
  }
} */