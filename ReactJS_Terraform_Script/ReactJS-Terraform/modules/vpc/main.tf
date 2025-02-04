resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
}

output "vpc_id" {
  value = aws_vpc.my-vpc.id
}