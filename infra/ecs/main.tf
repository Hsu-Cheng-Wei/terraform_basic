resource "aws_ecs_cluster" "cluster" {
    name = "${module.global_var.prefix}-cluster"

    tags = {
       Name = "${module.global_var.prefix}-cluster"
    }
}

resource "aws_ecs_task_definition" "task_definition" {
    family                   = module.global_var.task_definition.family
    requires_compatibilities = module.global_var.task_definition.requires_compatibilities
    cpu                      = module.global_var.task_definition.cpu
    memory                   = module.global_var.task_definition.memory
    network_mode             = module.global_var.task_definition.network_mode
    container_definitions    = module.global_var.task_definition.container_definitions

    execution_role_arn       = aws_iam_role.task_role.arn
}

resource "aws_iam_role" "task_role" {
  name = "${module.global_var.prefix}-task-execution-role"

  assume_role_policy = <<ROLEPOLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
ROLEPOLICY
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = "${aws_iam_role.task_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}