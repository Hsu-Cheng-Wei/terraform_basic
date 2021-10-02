module "lb_var" {
    source = "../../lb"  
}

data "aws_lb_target_group" "lb_target" {
  name = module.lb_var.target_name
}