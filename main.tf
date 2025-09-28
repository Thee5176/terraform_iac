// Use modular resources stored in terraform_iac/resources
module "vpc" {
  source = "./resources/vpc"

  project_name     = var.project_name
  environment_name = var.environment_name
}

module "ec2" {
  source = "./resources/ec2"

  project_name         = var.project_name
  environment_name     = var.environment_name
  command_service_port = var.command_service_port
  query_service_port   = var.query_service_port
  vpc_id               = module.vpc.vpc_id
  web_subnet_id        = module.vpc.web_subnet_id
}

module "rds" {
  source = "./resources/rds"

  project_name     = var.project_name
  environment_name = var.environment_name

  db_username   = var.db_username
  db_password   = var.db_password
  db_schema     = var.db_schema
  vpc_id        = module.vpc.vpc_id
  db_subnet_ids = module.vpc.db_subnet_ids
  web_sg_id     = module.ec2.web_sg_id
}

module "alb" {
  source = "./resources/alb"

  project_name     = var.project_name
  environment_name = var.environment_name
  vpc_id           = module.vpc.vpc_id
  alb_subnet_ids   = module.vpc.alb_subnet_ids
  ec2_instance_id  = module.ec2.ec2_instance_id
  domain_name      = var.domain_name
}