variable "project_name" {
  description = "Name prefix to tag monitoring resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to enable flow logs"
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling Group name to monitor CPU"
  type        = string
}

variable "alert_email" {
  description = "Email address to receive SNS alerts"
  type        = string
}
