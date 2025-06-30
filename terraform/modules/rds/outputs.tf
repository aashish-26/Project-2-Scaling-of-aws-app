output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "read_replica_endpoint" {
  value = aws_db_instance.read_replica[0].endpoint
}
