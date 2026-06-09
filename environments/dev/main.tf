terraform {
  required_version = ">=1.5"
}

provider "aws" {
  region = "eu-north-1"
}

// create a VPC on aws

module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr

}

// create a public subnet on the created VPC
module "public_subnet" {
  source = "../../modules/subnet"

  vpc_id            = module.vpc.vpc_id
  subnet_cidr       = var.public_subnet_cidr
  availability_zone = var.availability_zone
  subnet_name       = "public-subnet"
  public_subnet     = true
}

// Create a Private subnet on the Created VPC as well
module "private_subnet" {
  source = "../../modules/subnet"

  vpc_id            = module.vpc.vpc_id
  subnet_cidr       = var.private_subnet_cidr
  availability_zone = var.availability_zone
  subnet_name       = "private-subnet"
  public_subnet     = false
}

// create an internetgateway for the access of the subnets to the internet
module "internet_gateway" {
  source = "../../modules/internet-gateway"

  vpc_id = module.vpc.vpc_id
}

// Create a route table for public subnet to access internet through IGW
module "public_route_table" {
  source = "../../modules/route-table"

  vpc_id              = module.vpc.vpc_id
  subnet_id           = module.public_subnet.subnet_id
  internet_gateway_id = module.internet_gateway.igw_id

  route_table_name = "public-route-table"
}

// create a security groups for in and outbound rules
module "web_sg" {
  source = "../../modules/security-group"

  vpc_id = module.vpc.vpc_id

  security_group_name = "web-sg"
  ssh_allowed_cidrs   = var.ssh_allowed_cidrs
}

// create public ec2 instance
module "public_ec2" {
  source = "../../modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type

  subnet_id = module.public_subnet.subnet_id

  security_group_id = module.web_sg.security_group_id

  instance_name = "public-ec2"
}

// create private ec2 instance
module "private_ec2" {
  source = "../../modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type

  subnet_id = module.private_subnet.subnet_id

  security_group_id = module.web_sg.security_group_id

  instance_name = "private-ec2"
}