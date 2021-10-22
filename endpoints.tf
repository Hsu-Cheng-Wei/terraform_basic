// https://github.com/clowdhaus/terraform-aws-vpc-endpoints
module "endpoints" {
  source  = "clowdhaus/vpc-endpoints/aws"
  version = "v1.1.0"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [aws_security_group.sg_endpoint.id]

  endpoints = {
    ecr_dkr = {
        service             = "ecr.dkr"
        service_type        = "Interface"
        private_dns_enabled = true
        tags                = { Name = "${local.region}-ecr-dkr"}
        subnet_ids          = module.vpc.private_subnets
    }

    ecr_api = {
        service             = "ecr.api"
        service_type        = "Interface"
        private_dns_enabled = true
        tags                = { Name = "${local.region}-ecr-api"}
        subnet_ids          = module.vpc.private_subnets
    }

    s3 = {
        service             = "s3"
        service_type        = "Gateway"
        tags                = { Name = "${local.region}-s3"}
        route_table_ids     = module.vpc.private_route_table_ids
    }

    lambda = {
        service             = "lambda"
        service_type        = "Interface"
        tags                = { Name = "${local.region}-lambda"}
        private_dns_enabled = true        
        subnet_ids          = module.vpc.private_subnets
    }

    logs = {
        service             = "logs"
        service_type        = "Interface"
        tags                = { Name = "${local.region}-logs"}
        private_dns_enabled = true
        subnet_ids          = module.vpc.private_subnets      
    }
  }

  tags = {
    Name        = "${local.prefix}-endpoint"
    Environment = local.environment
  }

  depends_on = [
    module.vpc
  ]
}

resource "aws_security_group" "sg_endpoint" {  
  vpc_id = module.vpc.vpc_id

  name = "${local.prefix}-sg-endpoint"

  ingress = [
    {
      description = "Only allow ${local.prefix}-vpc cidr"
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks = [module.vpc.vpc_cidr_block]
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
    Name = "${local.prefix}-sg-endpoint"
  }

  depends_on = [
    module.vpc
  ]  
}