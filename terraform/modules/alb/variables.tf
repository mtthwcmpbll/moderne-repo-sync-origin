variable "name" {
  description = "Name for the ALB resources"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 8080
}

variable "internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB"
  type        = bool
  default     = false
}

# Health check settings
variable "health_check_path" {
  description = "Path for health checks"
  type        = string
  default     = "/actuator/health"
}

variable "health_check_matcher" {
  description = "HTTP codes to consider healthy"
  type        = string
  default     = "200-299"
}

variable "health_check_interval" {
  description = "Interval between health checks"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of consecutive successful checks to be healthy"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Number of consecutive failed checks to be unhealthy"
  type        = number
  default     = 3
}

variable "deregistration_delay" {
  description = "Time to wait before deregistering targets"
  type        = number
  default     = 30
}

# HTTPS settings
variable "certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
  default     = ""
}

variable "ssl_policy" {
  description = "SSL policy for HTTPS listener"
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

variable "redirect_http_to_https" {
  description = "Redirect HTTP to HTTPS"
  type        = bool
  default     = false
}
