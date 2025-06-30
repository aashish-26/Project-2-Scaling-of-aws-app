resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project_name}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-rds-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow access from EC2 app tier"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

resource "aws_db_instance" "main" {
  identifier              = "${var.project_name}-rds"
  engine                  = "mysql"
  engine_version          = var.engine_version
  instance_class          = var.instance_type
  allocated_storage       = var.allocated_storage
  username                = var.db_username
  password                = var.db_password
  multi_az                = true
  storage_encrypted       = true
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]

  tags = {
    Name = "${var.project_name}-rds"
  }
}

resource "aws_db_instance" "read_replica" {
  count                      = var.enable_read_replica ? 1 : 0
  identifier                 = "${var.project_name}-replica"
  instance_class             = var.replica_instance_type
  replicate_source_db        = aws_db_instance.main.identifier
  skip_final_snapshot        = true
  db_subnet_group_name       = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids     = [aws_security_group.rds_sg.id]
  publicly_accessible        = false

  tags = {
    Name = "${var.project_name}-read-replica"
  }
}
