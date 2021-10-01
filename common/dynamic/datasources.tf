data "aws_vpc" "vpc" {
    tags = module.network_var.vpc_tags
}

data "aws_subnet_ids" "vpc_subnet_ids" {
    vpc_id = data.aws_vpc.vpc.id
}

data "aws_subnet_ids" "vpc_public_subnet_ids" {
    vpc_id = data.aws_vpc.vpc.id

    filter {
      name = "tag:Name"
      values = local.public_subnet_names
    }
}

data "aws_subnet_ids" "vpc_private_subnet_ids" {
    vpc_id = data.aws_vpc.vpc.id

    filter {
      name = "tag:Name"
      values = local.private_subnet_names
    }
}