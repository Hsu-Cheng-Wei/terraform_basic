locals {
  public_subnet_names = values({ for i, v in module.network_var.vpc_public_subnets : i => v.name})
  private_subnet_names = values({ for i, v in module.network_var.vpc_private_subnets : i => v.name})  
}