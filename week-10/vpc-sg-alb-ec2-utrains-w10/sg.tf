resource "aws_security_group" "sg1" {
  name        = "webserver-sg"
  description = "Allow http"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "allow http"
    from_port       = var.http_port
    to_port         = var.http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.sg2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    env                  = var.env
    created-by-terraform = "yes"
  }
}

resource "aws_security_group" "sg2" {
  name        = "alb-sg"
  description = "Allow http and https"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "allow http"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow http"
    from_port   = var.https_port
    to_port     = var.https_port
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
    env                  = var.env
    created-by-terraform = "yes"
  }
}