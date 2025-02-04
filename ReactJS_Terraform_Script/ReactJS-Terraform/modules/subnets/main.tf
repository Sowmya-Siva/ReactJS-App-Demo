resource "aws_subnet" "public-subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private-subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}