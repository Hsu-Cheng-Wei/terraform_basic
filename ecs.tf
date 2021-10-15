resource "aws_ecs_cluster" "cluster" {
    name = "${local.prefix}-cluster"

    tags = {
       Name = "${local.prefix}-cluster"
       Enviroment = local.environment
    }
}


resource "aws_security_group" "sg_ecs_service" {  
  vpc_id = module.vpc.vpc_id

  name = "${local.prefix}-sg-ecs-service"

  ingress = [
    {
      description = "Only allow http 80 port"
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
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
    Name = "${local.prefix}-sg-ecs-service"
  }

  depends_on = [
    module.vpc
  ]
}

resource "aws_ecs_service" "service" {
    name = "${local.prefix}-ecs-service"
    cluster = aws_ecs_cluster.cluster.arn
    task_definition = aws_ecs_task_definition.hello_world_task_definition.arn
    desired_count = 2
    launch_type = "FARGATE"
    network_configuration {
        subnets = module.vpc.private_subnets
        security_groups = [aws_security_group.sg_ecs_service.id]
        #assign_public_ip = true
    }

    load_balancer {
        target_group_arn = module.alb.target_groups["${local.ap_lb_prefix_name}-target-group"].arn
        container_name   = "hello-world"
        container_port   = 80        
    }

    depends_on = [
      module.alb,
      module.vpc,
      module.endpoints,
      aws_security_group.sg_ecs_service,
      aws_ecs_cluster.cluster,
    ]
}