# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

module "vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.app
  }

  env                = var.environment
  name               = var.app_name
  azs                = var.vpc_config.azs
  cidr               = var.vpc_config.cidr[0]
  private_subnets    = var.vpc_config.private_subnets
  public_subnets     = var.vpc_config.public_subnets
  enable_nat_gateway = true
  single_nat_gateway = false
}

module "verified_access_sg" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1"
  providers = {
    aws = aws.app
  }

  name                = "${var.app_name}-endpoint-sg"
  description         = "Security group to restrict https access to the AVA endpoint"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp"]
  egress_rules        = ["all-all"]
}

module "acm" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"
  providers = {
    aws = aws.app
  }

  domain_name         = "${var.app_name}.${var.hosted_zone_name}"
  zone_id             = var.hosted_zone_id
  validation_method   = "DNS"
  wait_for_validation = true
}

module "ecs" {
  source = "./modules/ecs"
  providers = {
    aws = aws.app
  }

  app_name         = var.app_name
  vpc_id           = module.vpc.vpc_id
  vpc_cidr         = module.vpc.vpc_cidr
  private_subnets  = module.vpc.private_subnets
  public_subnets   = module.vpc.public_subnets
  environment_list = []
  acm_certificate  = module.acm.acm_certificate_arn
}
