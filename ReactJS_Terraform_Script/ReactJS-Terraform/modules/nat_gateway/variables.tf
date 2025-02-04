variable "vpc_id" {
  description = "VPC ID where NAT will be deployed"
  type        = string
}

variable "public_subnet" {
  description = "Public subnet ID for NAT Gateway"
  type        = string
}