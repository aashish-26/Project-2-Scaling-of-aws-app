module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "ec2" {
  source              = "./modules/ec2-asg"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  alb_sg_id           = module.alb.alb_sg_id
  target_group_arn    = module.alb.target_group_arn
  ami_id              = var.ami_id
  user_data           = filebase64("user_data.sh")
}

module "rds" {
  source              = "./modules/rds"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  ec2_sg_id           = module.ec2.app_sg_id
  db_username         = var.db_username
  db_password         = var.db_password
}

module "redis" {
  source              = "./modules/redis"
  project_name        = var.project_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  ec2_sg_id           = module.ec2.app_sg_id
}

module "s3_cloudfront" {
  source        = "./modules/s3-cloudfront"
  project_name  = var.project_name
}

module "monitoring" {
  source        = "./modules/monitoring"

  project_name  = var.project_name
  vpc_id        = module.vpc.vpc_id
  asg_name      = module.ec2.asg_name
  alert_email   = var.alert_email
}
