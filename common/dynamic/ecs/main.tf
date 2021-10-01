module "ecs_var" {
    source = "../../ecs"  
}

data "aws_ecs_cluster" "cluster" {
  cluster_name = module.ecs_var.cluster_name
}

data "aws_ecs_task_definition" "task_definition" {
  task_definition  = module.ecs_var.task_definition.family
}