module "vpc_core" {
  source = "./vpc_core"

  vpc_cidr    = var.vpc_cidr
  environment = var.environment
}

module "subnets" {
  source = "./subnets"

  vpc_id              = module.vpc_core.vpc_id
  vpc_cidr            = var.vpc_cidr
  environment         = var.environment
  availability_zones  = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "internet_gateway" {
  source = "./internet_gateway"

  vpc_id      = module.vpc_core.vpc_id
  environment = var.environment
}

module "nat_gateway" {
  source = "./nat_gateway"

  vpc_id           = module.vpc_core.vpc_id
  public_subnet_id = module.subnets.public_subnet_ids[0]
  environment      = var.environment
  
  depends_on = [module.internet_gateway]
}

module "route_tables" {
  source = "./route_tables"

  vpc_id            = module.vpc_core.vpc_id
  environment       = var.environment
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  nat_gateway_id    = module.nat_gateway.nat_gateway_id
  public_subnet_ids = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
}

module "network_acls" {
  source = "./network_acls"

  vpc_id            = module.vpc_core.vpc_id
  vpc_cidr          = var.vpc_cidr
  environment       = var.environment
  public_subnet_ids = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
}
