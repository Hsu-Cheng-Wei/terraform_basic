module "network" {
  source = "./network"
}

module "endpoint" {
  source = "./endpoints"

  depends_on = [
    module.network.vpc,
    module.network.public_subnets,
    module.network.private_subnets,  
  ]
}

module "lb" {
  source = "./lbs"
  depends_on = [
    module.endpoint.endpoint_ecr_dkr
  ]
}

module "ecs" {
  source = "./ecs"  
}