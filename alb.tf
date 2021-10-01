locals {
  ap_lb_prefix_name = "${local.prefix}-lb"
}

// https://github.com/infrablocks/terraform-aws-application-load-balancer
module "alb" {
  source  = "infrablocks/application-load-balancer/aws"
  region = local.region
  vpc_id = module.vpc.vpc_id

  version =  "3.0.0"
  expose_to_public_internet = "yes"
  subnet_ids = module.vpc.public_subnets

  component = local.prefix
  deployment_identifier = "production"

  security_groups = {
    default = {
      associate: "yes"
      ingress_rule: {
        include: "yes",
        cidrs: ["0.0.0.0/0"]
      },
      egress_rule: {
        include: "yes",
        from_port: 0,
        to_port: 65535,
        cidrs:  ["0.0.0.0/0"]
      }
    }
  }

  target_groups = [
    {
      key = "${local.ap_lb_prefix_name}-target-group"
      port = "80"
      protocol = "HTTP"
      target_type = "ip"
      health_check = {
        path: "/health",
        port: "80",
        protocol: "HTTP",
        interval: 25,
        healthy_threshold: 10,
        unhealthy_threshold: 10
      }
    }
  ]

  listeners = [
    {
      key = "${local.ap_lb_prefix_name}-listeners"
      port = "80"
      protocol = "HTTP"
      certificate_arn = ""

      default_action = {
        type = "forward",
        target_group_key = "${local.ap_lb_prefix_name}-target-group"
      }
    }
  ]

  idle_timeout = 60

  depends_on = [
    module.vpc
  ]
}