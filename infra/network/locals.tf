locals {
  private_subnets = values({for i, v in aws_subnet.main_public_subnets: i =>
  {
    id = v.id
    name = v.tags_all["Name"]
    is_public = true
  }})

  public_subnets = values({for i, v in aws_subnet.main_private_subnets: i =>
  {
    id = v.id
    name = v.tags_all["Name"]
    is_public = false
  }})

  subnets = concat(local.private_subnets, local.public_subnets)
}