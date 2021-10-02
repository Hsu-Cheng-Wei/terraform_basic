resource "aws_security_group" "sg_ecs_service" {  
  vpc_id = module.dynamic_network_var.vpc.id

  name = module.global_var.prefix

  ingress = [
    {
      description = "Only allow http 80 port"
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = [module.dynamic_network_var.vpc.cidr_block]
      ipv6_cidr_blocks = null
      prefix_list_ids = null
      security_groups = null
      self = null
    }
  ]

  egress = [
    {
      description = "Allow all"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null
      security_groups = null
      self = null
    }    
  ]

  tags = {
    Name = "${module.global_var.prefix}-sg-ecs-service"
  }
}

resource "aws_ecs_service" "service" {
    name = "${module.global_var.prefix}-ecs-service"
    cluster = module.dynamic_ecs_var.cluster.arn
    task_definition = "${module.dynamic_ecs_var.task_definition.family}:${module.dynamic_ecs_var.task_definition.revision}"
    desired_count = 2
    launch_type = "FARGATE"
    network_configuration {
        subnets = module.dynamic_network_var.vpc_subnet_private_ids
        security_groups = [aws_security_group.sg_ecs_service.id]
    }

    load_balancer {
        target_group_arn = module.dynamic_lb_var.lb_target.arn
        container_name   = "hello-world"
        container_port   = 80        
    }
}
