resource "aws_ecs_cluster" "cluster" {
    name = module.global_var.cluster_name

    tags = {
       Name = module.global_var.cluster_name
    }
}

resource "aws_ecs_task_definition" "task_definition" {
    family                   = module.global_var.task_definition.family
    requires_compatibilities = module.global_var.task_definition.requires_compatibilities
    cpu                      = module.global_var.task_definition.cpu
    memory                   = module.global_var.task_definition.memory
    network_mode             = module.global_var.task_definition.network_mode
    container_definitions    = module.global_var.task_definition.container_definitions

    execution_role_arn       = aws_iam_role.task_execution_role.arn

    depends_on = [
      aws_iam_role.task_role,
      aws_iam_role.task_execution_role
    ]
}
