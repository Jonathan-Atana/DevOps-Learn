resource "aws_lb_target_group" "main" {
  name     = "alb-tg"
  port     = var.http_port
  protocol = locals.http_protocol
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/"
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    timeout             = 6
    protocol            = locals.http_protocol
    port                = "traffic-port"
    unhealthy_threshold = 3
  }

  depends_on = [module.vpc]
}

# Attach instances to the target group
resource "aws_lb_target_group_attachment" "main" {
  count            = length(aws_instance.server)  # Attach all instances to the target group
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.server[count.index].id
  port             = var.http_port
}

# Create the ALB
resource "aws_lb" "alb" {
  name                       = "alb"
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sg2.id]
  subnets                    = module.vpc.public_subnets
  enable_deletion_protection = false
}

# Create the ALB listener
resource "aws_lb_listener" "alb-listener" {
  port              = var.http_port
  protocol          = locals.http_protocol
  load_balancer_arn = aws_lb.alb.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}