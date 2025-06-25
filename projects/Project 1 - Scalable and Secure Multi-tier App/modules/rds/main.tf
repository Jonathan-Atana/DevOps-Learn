resource "aws_db_instance" "this" {
  allocated_storage = 20

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"

  db_name  = "${var.namespace}-db"
  username = var.username
  password = var.password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]

  skip_final_snapshot = true
  publicly_accessible = false

  tags = {
    Name = "${var.namespace}-rds"
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.namespace}-db-subnet-group"
  subnet_ids = var.subnet_group_subnet_ids != null ? var.subnet_group_subnet_ids : [var.subnet_id]

  tags = {
    Name = "${var.namespace}-db-subnet-group"
  }
}
