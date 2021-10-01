output "vpc" {
    value = data.aws_vpc.vpc
}

output "vpc_subnet_ids" {
    value = data.aws_subnet_ids.vpc_subnet_ids.ids
}

output "vpc_subnet_public_ids" {
    value = data.aws_subnet_ids.vpc_public_subnet_ids.ids
}

output "vpc_subnet_private_ids" {
    value = data.aws_subnet_ids.vpc_private_subnet_ids.ids
}
