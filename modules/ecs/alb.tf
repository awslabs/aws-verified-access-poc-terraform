# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

module "alb" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "alb-${var.app_name}"

  internal              = true
  load_balancer_type    = "application"
  vpc_id                = var.vpc_id
  subnets               = var.private_subnets
  create_security_group = false
  security_groups       = [module.alb_sg.security_group_id]

  target_groups = [
    {
      name             = "tg-alb-${var.app_name}-app"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 15
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.acm_certificate
      target_group_index = 0
    }
  ]
}
