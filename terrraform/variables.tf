variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "ami_id" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "project_name" {
  description = "Name prefix for all tagged resources"
  type        = string
}

variable "alert_email" {
  description = "Email address to receive CloudWatch/SNS alerts"
  type        = string
}
