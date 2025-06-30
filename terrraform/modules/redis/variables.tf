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
  type = string
}

variable "node_type" {
  description = "Redis node type"
  type        = string
  default     = "cache.t2.micro"
}
