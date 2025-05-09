output "vpc_id" {
  value = module.vpc_core.vpc_id
}

output "vpc_cidr" {
  value = module.vpc_core.vpc_cidr
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "internet_gateway_id" {
  value = module.internet_gateway.internet_gateway_id
}

output "nat_gateway_id" {
  value = module.nat_gateway.nat_gateway_id
}