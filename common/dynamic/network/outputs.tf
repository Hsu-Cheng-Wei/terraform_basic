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

output "vpc_public_route_table_ids" {
    value = data.aws_route_tables.public_route_tables.ids
}

output "vpc_private_route_table_ids" {
    value = data.aws_route_tables.private_route_tables.ids
}