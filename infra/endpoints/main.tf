resource "aws_security_group" "sg_ecr" {  
  vpc_id = module.dynamic_network_var.vpc.id

  name = "${module.global_var.prefix}-sg-endpoint-ecr"

  ingress = [
    {
      description = "Only allow vpc main"
      from_port = 0
      to_port   = 0
      protocol  = "-1"
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
    Name = "${module.global_var.prefix}-sg-endpoint-ecr"
  }
}
/*------------------Endpoint-ECR-DKR----------------*/
resource "aws_vpc_endpoint" "endpoint_ecr_dkr" {
  vpc_id       = module.dynamic_network_var.vpc.id
  service_name = "com.amazonaws.${module.global_var.zone}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [
    aws_security_group.sg_ecr.id
  ]

  subnet_ids = values({ for i, v in module.dynamic_network_var.vpc_subnet_private_ids: i => v })

  tags = {
    Name = "${module.global_var.prefix}-endpoint-ecr-dkr"
  }

  depends_on = [
    aws_security_group.sg_ecr
  ]
}
/*--------------------------------------------------*/

/*------------------Endpoint-ECR-API----------------*/
resource "aws_vpc_endpoint" "endpoint_ecr_api" {
  vpc_id       = module.dynamic_network_var.vpc.id
  service_name = "com.amazonaws.${module.global_var.zone}.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [
    aws_security_group.sg_ecr.id
  ]

  subnet_ids = values({ for i, v in module.dynamic_network_var.vpc_subnet_private_ids: i => v })

  tags = {
    Name = "${module.global_var.prefix}-endpoint-ecr-api"
  }

  depends_on = [
    aws_security_group.sg_ecr
  ]
}
/*--------------------------------------------------*/

/*------------------S3 Endpoint---------------------*/
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.dynamic_network_var.vpc.id
  service_name = "com.amazonaws.${module.global_var.zone}.s3"
  route_table_ids = module.dynamic_network_var.vpc_private_route_table_ids
  tags = {
    Name = "${module.global_var.prefix}-endpoint-S3"
  }
}
/*--------------------------------------------------*/