# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

module "alb_sg" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1"

  name        = "${var.app_name}-alb-sg"
  description = "Security group to restrict access to the ALB"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = [var.vpc_cidr]

  ingress_rules = [
    "https-443-tcp"
  ]

  egress_rules = ["all-all"]
}

module "ecs_service_sg" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1"

  name        = "${var.app_name}-app-ecs-service-sg"
  description = "Security group to restrict access to ECS app"
  vpc_id      = var.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_sg.security_group_id
    }
  ]

  egress_rules = ["all-all"]
}
