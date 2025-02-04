variable "subnet_id" {
  description = "Private subnet ID for EC2"
  type        = string
}

variable "security_group" {
  description = "Security group ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ecr_repo_url" {
  description = "ECR repository URL"
  type        = string
}
