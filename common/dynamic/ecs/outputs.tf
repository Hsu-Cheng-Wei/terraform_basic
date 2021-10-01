output "cluster" {
  value = data.aws_ecs_cluster.cluster
}

output "task_definition" {
  value = data.aws_ecs_task_definition.task_definition
}
