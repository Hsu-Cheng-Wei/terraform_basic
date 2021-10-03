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

module "s3" {
    source = "./s3"
}