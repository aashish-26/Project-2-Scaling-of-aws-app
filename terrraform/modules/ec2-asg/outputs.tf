output "asg_name" {
  value = aws_autoscaling_group.app_asg.name
}

output "app_sg_id" {
  description = "Security Group ID for EC2 app instances"
  value       = aws_security_group.app_sg.id
}