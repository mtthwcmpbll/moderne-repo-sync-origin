terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "terraform"
      Project     = var.project_name
    }
  }
}

# Shared networking
module "networking" {
  source = "../../../modules/networking"

  app_name           = var.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}

# Shared ECS cluster
module "ecs_cluster" {
  source = "../../../modules/ecs-cluster"

  cluster_name              = "${var.project_name}-${var.environment}"
  environment               = var.environment
  enable_container_insights = var.enable_container_insights
}

# Per-app ALB
module "alb" {
  source   = "../../../modules/alb"
  for_each = var.apps

  name                       = each.key
  environment                = var.environment
  vpc_id                     = module.networking.vpc_id
  subnet_ids                 = module.networking.public_subnet_ids
  container_port             = each.value.container_port
  health_check_path          = each.value.health_check_path
  certificate_arn            = lookup(each.value, "certificate_arn", "")
  redirect_http_to_https     = lookup(each.value, "redirect_http_to_https", false)
  enable_deletion_protection = var.environment == "prod"
}

# Per-app ECS service
module "ecs_service" {
  source   = "../../../modules/ecs-service"
  for_each = var.apps

  service_name          = each.key
  environment           = var.environment
  aws_region            = var.aws_region
  cluster_id            = module.ecs_cluster.cluster_id
  cluster_name          = module.ecs_cluster.cluster_name
  vpc_id                = module.networking.vpc_id
  subnet_ids            = module.networking.private_subnet_ids
  container_image       = each.value.container_image
  container_port        = each.value.container_port
  cpu                   = each.value.cpu
  memory                = each.value.memory
  desired_count         = each.value.desired_count
  target_group_arn      = module.alb[each.key].target_group_arn
  alb_security_group_id = module.alb[each.key].security_group_id
  environment_variables = lookup(each.value, "environment_variables", {})
  secrets               = lookup(each.value, "secrets", {})

  # Auto-scaling
  enable_autoscaling = lookup(each.value, "enable_autoscaling", true)
  min_capacity       = lookup(each.value, "min_capacity", 2)
  max_capacity       = lookup(each.value, "max_capacity", 10)
  cpu_target_value   = lookup(each.value, "cpu_target_value", 70)
}
