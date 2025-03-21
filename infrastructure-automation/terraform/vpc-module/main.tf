provider "aws" {
  region = "me-central-1"
}

module "vpc" {
  source     = "./vpc"
}

module "subnets" {
  source             = "./subnets"
  vpc_id = module.vpc.vpc_id 
}

module "security_groups" {
  source = "./securityGroups"
  vpc_id = module.vpc.vpc_id 
}

module "gateways" {
  source = "./gateways"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
}