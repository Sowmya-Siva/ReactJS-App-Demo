provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source   = "./vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source = "./subnets"
  vpc_id = module.vpc.vpc_id
}

module "nat" {
  source        = "./nat"
  vpc_id        = module.vpc.vpc_id
  public_subnet = module.subnets.public_subnet_id
}

module "security" {
  source = "./security"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source         = "./ec2"
  subnet_id      = module.subnets.private_subnet_id
  security_group = module.security.sg_id
  instance_type  = var.instance_type
  aws_region     = var.aws_region
  ecr_repo_url   = var.ecr_repo_url
}
