module "global_var" {
    source = "../../common"
}

/*------------------------Basci network configuration--------------------*/
resource "aws_vpc" "main" {
    cidr_block = module.global_var.vpc_cidr_block
    enable_dns_hostnames = true
    tags = module.global_var.vpc_tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = module.global_var.igw_tags

  depends_on = [
    aws_vpc.main
  ]
}

resource "aws_subnet" "main_public_subnets" {
  for_each = { for i, v in module.global_var.vpc_public_subnets : i => v}
  
  vpc_id     = aws_vpc.main.id
  
  cidr_block = each.value.cidr_block
  
  availability_zone = each.value.zone
  
  tags = {
    Name = "${each.value.name}"
  }

  depends_on = [
    aws_vpc.main
  ]
}

resource "aws_subnet" "main_private_subnets" {
  for_each = { for i, v in module.global_var.vpc_private_subnets : i => v}
  
  vpc_id     = aws_vpc.main.id
  
  cidr_block = each.value.cidr_block
  
  availability_zone = each.value.zone
  
  tags = {
    Name = "${each.value.name}"
  }

  depends_on = [
    aws_vpc.main
  ]
}

/*------------------------------------------------------------------------*/

/*---------------------VPC Route Table Configuration----------------------*/
resource "aws_route_table" "private_route_table" {
  for_each = {for i, v in aws_subnet.main_private_subnets: i => v}
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${each.value.tags_all["Name"]}-route_table"
    subnet_id = each.value.id
    subnet_name = each.value.tags_all["Name"]
  }

  depends_on = [
    aws_subnet.main_private_subnets    
  ]
}

resource "aws_route_table" "public_route_table" {
  for_each = {for i, v in aws_subnet.main_public_subnets: i => v}
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${each.value.tags_all["Name"]}-route_table"
    subnet_id = each.value.id
    subnet_name = each.value.tags_all["Name"]
  }

  depends_on = [
    aws_subnet.main_public_subnets    
  ]  
}

resource "aws_route" "route_for_public" {
  for_each = {for i, v in aws_route_table.public_route_table: i => v}

  route_table_id            = each.value.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id

  depends_on = [
    aws_route_table.public_route_table
  ]
}

resource "aws_route_table_association" "private_route_table_association" {
  for_each = {for i, v in aws_route_table.private_route_table: i => v}

  subnet_id      = each.value.tags_all["subnet_id"]
  route_table_id = each.value.id

  depends_on = [
    aws_route_table.private_route_table    
  ]
}

resource "aws_route_table_association" "public_route_table_association" {
  for_each = {for i, v in aws_route_table.public_route_table: i => v}

  subnet_id      = each.value.tags_all["subnet_id"]
  route_table_id = each.value.id

  depends_on = [
    aws_route_table.public_route_table    
  ]  
}
/*------------------------------------------------------------------------*/