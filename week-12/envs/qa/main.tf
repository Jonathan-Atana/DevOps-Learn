provider "aws" {
  region = var.region
}

/*
module "s3" {
  source = "../../../modules/storage/s3"

  bucket_name = var.bucket
  region_name = var.region
}

module "lightsail" {  # Create a Lightsail instance
  source = "../../../modules/compute/lightsail"

  server_name = "${var.project_prefix}-${var.env}-server"

  tags = {
    env = var.env
  }
}
*/

module "ec2" { # create an EC2 instance
  source = "../../../modules/compute/ec2"

  file_path       = "${path.root}/vars"

  tags = {
    env  = var.env
    Name = "${var.project_prefix}-${var.env}-server"
  }
}

/* module "attach_ebs" {
  source = "../../../modules/storage/attach_ebs"

  device_name = "/${var.env}/xvdf"
  az          = "${var.region}a"
  volume_size = 10
  instance_id = module.ec2.instance-id

  tags = {
    Name = "${var.env}-MyEBSVolume"
  }
} */