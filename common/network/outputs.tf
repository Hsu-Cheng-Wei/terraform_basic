output "igw_tags" {
  value = local.igw_tags
}

output "vpc_tags" {
  value = local.vpc_tags
}

output "vpc_cidr_block" {
  value = local.vpc_cidr_block
}

output "vpc_public_subnets" {
  value = local.vpc_public_subnets
}

output "vpc_private_subnets" {
  value = local.vpc_private_subnets
}
