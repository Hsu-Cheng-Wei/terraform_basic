resource "aws_security_group" "sg_cache" {  
  vpc_id = module.dynamic_network_var.vpc.id

  name = "${module.global_var.prefix}-sg_cache"

  ingress = [
    {
      description = "Only allow Redis Port 6379"
      from_port = 6379
      to_port   = 6379
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
    Name = "${module.global_var.prefix}-sg_cache"
  }
}
resource "aws_elasticache_subnet_group" "subnet_group" {
  name       = "${module.global_var.prefix}-cache-subnet"
  subnet_ids = module.dynamic_network_var.vpc_subnet_private_ids
}

resource "aws_elasticache_cluster" "cache_cluster" {
  cluster_id           = "${module.global_var.prefix}-cluster"
  engine               = "redis"
  engine_version       = "6.x"
  port                 = 6379
  parameter_group_name = "default.redis6.x"  
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  
  subnet_group_name    = aws_elasticache_subnet_group.subnet_group.name
  security_group_ids   = [aws_security_group.sg_cache.id]

  tags = {
    Name = "${module.global_var.prefix}-cache-subnet"
  }
  depends_on           = [
    aws_security_group.sg_cache,
    aws_elasticache_subnet_group.subnet_group
  ]
}