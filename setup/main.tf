module "dynamic_var" {
    source = "../common/dynamic/"  
}

output "vpc_public_ids" {
  value = module.dynamic_var.vpc_subnet_public_ids
}

output "vpc_private_ids" {
  value = module.dynamic_var.vpc_subnet_private_ids
}