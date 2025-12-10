output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs_cluster.cluster_name
}

output "app_endpoints" {
  description = "ALB DNS names for each application"
  value       = { for app_name, alb in module.alb : app_name => alb.alb_dns_name }
}

output "app_target_groups" {
  description = "Target group ARNs for each application"
  value       = { for app_name, alb in module.alb : app_name => alb.target_group_arn }
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.networking.private_subnet_ids
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.networking.public_subnet_ids
}
