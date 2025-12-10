variable "repository_names" {
  description = "List of ECR repository names to create"
  type        = list(string)
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "image_count_to_keep" {
  description = "Number of tagged images to keep"
  type        = number
  default     = 30
}

variable "untagged_image_expiry_days" {
  description = "Days to keep untagged images"
  type        = number
  default     = 14
}

variable "replication_regions" {
  description = "List of regions to replicate images to"
  type        = list(string)
  default     = []
}
