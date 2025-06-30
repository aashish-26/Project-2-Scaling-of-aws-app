variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ec2_sg_id" {
  description = "Security group ID of the EC2 app"
  type        = string
}

variable "engine_version" {
  type    = string
  default = "8.0"
}

variable "instance_type" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "enable_read_replica" {
  type    = bool
  default = true
}

variable "replica_instance_type" {
  type    = string
  default = "db.t3.micro"
}
