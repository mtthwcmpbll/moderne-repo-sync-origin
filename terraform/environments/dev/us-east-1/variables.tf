variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights"
  type        = bool
  default     = true
}

variable "apps" {
  description = "Map of applications to deploy"
  type = map(object({
    container_image        = string
    container_port         = number
    cpu                    = number
    memory                 = number
    desired_count          = number
    health_check_path      = string
    environment_variables  = optional(map(string), {})
    secrets                = optional(map(string), {})
    certificate_arn        = optional(string, "")
    redirect_http_to_https = optional(bool, false)
    enable_autoscaling     = optional(bool, true)
    min_capacity           = optional(number, 2)
    max_capacity           = optional(number, 10)
    cpu_target_value       = optional(number, 70)
  }))
}
