module "global_var" {
    source = "../common/"  
}

module "dynamic_network_var" {
    source = "../common/dynamic/network"
}

module "dynamic_ecs_var" {
    source = "../common/dynamic/ecs"
}

module "dynamic_lb_var" {
    source = "../common/dynamic/lb"
}