aws_region         = "eu-west-1"
environment        = "staging"
project_name       = "myproject"
vpc_cidr           = "10.6.0.0/16"
availability_zones = ["eu-west-1a", "eu-west-1b"]

enable_container_insights = true

apps = {
  "api-service" = {
    container_image   = "123456789012.dkr.ecr.eu-west-1.amazonaws.com/api-service:staging"
    container_port    = 8080
    cpu               = 512
    memory            = 1024
    desired_count     = 2
    health_check_path = "/actuator/health"
    environment_variables = {
      SPRING_PROFILES_ACTIVE = "staging"
      LOG_LEVEL              = "DEBUG"
    }
    enable_autoscaling = true
    min_capacity       = 2
    max_capacity       = 8
    cpu_target_value   = 70
  }
}
