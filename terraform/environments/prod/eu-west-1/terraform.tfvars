aws_region         = "eu-west-1"
environment        = "prod"
project_name       = "myproject"
vpc_cidr           = "10.11.0.0/16"
availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

enable_container_insights = true

apps = {
  "api-service" = {
    container_image   = "123456789012.dkr.ecr.eu-west-1.amazonaws.com/api-service:v1.0.0"
    container_port    = 8080
    cpu               = 1024
    memory            = 2048
    desired_count     = 3
    health_check_path = "/actuator/health"
    environment_variables = {
      SPRING_PROFILES_ACTIVE = "prod"
      LOG_LEVEL              = "INFO"
    }
    enable_autoscaling = true
    min_capacity       = 3
    max_capacity       = 20
    cpu_target_value   = 60
  }

  "web-frontend" = {
    container_image   = "123456789012.dkr.ecr.eu-west-1.amazonaws.com/web-frontend:v1.0.0"
    container_port    = 3000
    cpu               = 512
    memory            = 1024
    desired_count     = 3
    health_check_path = "/health"
    environment_variables = {
      NODE_ENV = "production"
    }
    enable_autoscaling = true
    min_capacity       = 3
    max_capacity       = 15
    cpu_target_value   = 60
  }
}
