module "vpc" {
  source = "./modules/vpc"

  name                 = var.project_name
  cidr_block           = "10.0.0.0/16"
  public_subnet_a_cidr = "10.0.1.0/24"
  public_subnet_b_cidr = "10.0.2.0/24"
}

module "ecr" {
  source = "./modules/ecr"

  name                 = var.project_name
  image_tag_mutability = "MUTABLE"
  scan_on_push         = true
}

module "alb" {
  source = "./modules/alb"

  name              = var.project_name
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet_ids
  container_port    = var.container_port
  health_check_path = "/health"
  certificate_arn   = module.acm.certificate_arn
}

module "ecs" {
  source = "./modules/ecs"

  name                  = var.project_name
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.public_subnet_ids
  container_image       = var.container_image
  container_port        = var.container_port
  aws_region            = var.aws_region
  cpu                   = "256"
  memory                = "512"
  desired_count         = 1
  log_retention_days    = 7
  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn
  http_listener_arn     = module.alb.http_listener_arn
  environment_variables = []
}

module "acm" {
  source = "./modules/acm"

  name         = var.project_name
  domain_name  = var.domain_name
  subdomain    = var.subdomain
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}
