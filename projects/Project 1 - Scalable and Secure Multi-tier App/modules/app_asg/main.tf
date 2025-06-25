resource "aws_launch_template" "this" {
  name_prefix = var.name_prefix

  image_id               = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  user_data = base64encode(
    templatefile(
      "${path.root}/templates/user-data.sh", # path.root is where the terraform init/apply command is run
      {
        app_port = var.app_port # apache will be listening on this port (8080)
      }
    )
  )

  # Good practice when using a launch configuration/ template with an ASG
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name = var.name

  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity

  vpc_zone_identifier = var.vpc_zone_identifier
  target_group_arns   = var.target_group_arns

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
}