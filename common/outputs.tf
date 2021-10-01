output "prefix" {
  value = module.core.prefix
}

output "zone" {
  value = module.core.zone
}

output "igw_tags" {
  value = module.network.igw_tags
}

output "vpc_tags" {
  value = module.network.vpc_tags
}

output "vpc_cidr_block" {
  value = module.network.vpc_cidr_block
}

output "vpc_public_subnets" {
  value = module.network.vpc_public_subnets
}

output "vpc_private_subnets" {
  value = module.network.vpc_private_subnets
}

output "task_definition" {
  value = module.ecs.task_definition
}

