module "network" {
  source = "./network"
}

module "lb" {
  source = "./lbs"
  depends_on = [
    module.network.vpc,
    module.network.public_subnets,
    module.network.private_subnets,
  ]
}

module "endpoint" {
  source = "./endpoints"

  depends_on = [
    module.lb.listener
  ]
}

module "ecs" {
  source = "./ecs"
}