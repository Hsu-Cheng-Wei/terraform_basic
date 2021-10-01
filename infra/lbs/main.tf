resource "aws_security_group" "sg_lb" {  
  vpc_id = module.dynamic_network_var.vpc.id

  name = "${module.global_var.prefix}-sg-lb"

  ingress = [
    {
      description = "LoadBalance only allow http 80 port"
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
    Name = "${module.global_var.prefix}-sg-lb"
  }
}

/*------------------loadbalance----------------*/
resource "aws_lb" "lb" {
  name = "${module.global_var.prefix}-lb"
  load_balancer_type = "application"
  security_groups = [aws_security_group.sg_lb.id]
  subnets = module.dynamic_network_var.vpc_subnet_public_ids
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = module.global_var.lb_target_name
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = module.dynamic_network_var.vpc.id
}

resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.lb.arn
    
    port                = 80
    protocol            = "HTTP"
    ssl_policy          = ""
    certificate_arn     = ""

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.lb_target_group.arn
    }
}

/*---------------------------------------------*/