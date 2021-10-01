module "core" {
    source = "./core"
}

module "network" {
    source = "./network"
}

module "lb" {
    source = "./lb"
}

module "ecs" {
    source = "./ecs"
}