locals {
  vpc_prefix_name = "${local.prefix}-vpc"
}

// https://github.com/terraform-aws-modules/terraform-aws-vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.prefix}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_dns_hostnames = true

  vpc_tags = {
    Name = local.vpc_prefix_name
    Terraform = "true"
    Environment = local.environment
  }

  default_security_group_tags = {
    Name = "${local.vpc_prefix_name}-default-sg"
    Terraform = "true"
    Environment = local.environment
  }

  igw_tags = {
    Name = "${local.vpc_prefix_name}-igw"
    Terraform = "true"
    Environment = local.environment
  }

  default_route_table_tags = {
    Name = "${local.vpc_prefix_name}-default-route-table"
    Terraform = "true"
    Environment = local.environment
  }

  public_route_table_tags = {
    Name = "${local.vpc_prefix_name}-public-route-table"
    Terraform = "true"
    Environment = local.environment
  }

  private_route_table_tags = {
    Name = "${local.vpc_prefix_name}-private-route-table"
    Terraform = "true"
    Environment = local.environment
  }

  public_subnet_tags = {
    Name = "${local.vpc_prefix_name}-public-subnet"
    Terraform = "true"
    Environment = local.environment
  }

  private_subnet_tags = {
    Name = "${local.vpc_prefix_name}-private-subnet"
    Terraform = "true"
    Environment = local.environment
  }
}