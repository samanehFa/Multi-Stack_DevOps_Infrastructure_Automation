provider "aws" {
  region = "me-central-1"
}

module "security-groups" {
  source     = "./security-groups"
}

module "instances" {
  source             = "./instances"
  postgres-sg = module.security-groups.postgres-sg
  redis-worker-sg = module.security-groups.redis-worker-sg
  vote-result-sg = module.security-groups.vote-result-sg
  bastion-sg = module.security-groups.bastion-sg
}

module "loadbalancer" {
  source = "./loadbalancer"
  alb-sg = module.security-groups.alb-sg
  frontend-vote-result = module.instances.frontend-vote-result 
}

