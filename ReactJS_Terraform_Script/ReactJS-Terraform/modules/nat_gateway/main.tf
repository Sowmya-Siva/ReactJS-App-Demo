resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

resource "aws_eip" "nat_eip" {}

resource "aws_nat_gateway" "nat" {
  subnet_id     = var.public_subnet
  allocation_id = aws_eip.nat_eip.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}