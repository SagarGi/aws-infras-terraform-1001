terraform {
  required_version = ">=1.5"
}

provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
  
}