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