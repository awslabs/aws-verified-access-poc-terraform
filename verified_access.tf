# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

module "verified_access" {
  source = "./modules/va"

  app_name              = var.app_name
  policy_reference_name = "IAM"
  policy_document       = <<EOT
  permit(principal, action, resource)
  when {
    context.http_request.http_method != "INVALID_METHOD"
  };
EOT
}

module "ram" {
  source = "./modules/ram"
  count  = local.prereqs_out.single_account ? 0 : 1

  app_name     = var.app_name
  resource_arn = module.verified_access.va_group_arn
  aws_org_arn  = data.aws_organizations_organization.org.arn
}

module "verified_access_endpoint" {
  source = "./modules/va_endpoint"
  providers = {
    aws = aws.app
  }

  app_name                        = var.app_name
  application_domain              = "${var.app_name}.${var.hosted_zone_name}"
  domain_certificate_arn          = module.acm.acm_certificate_arn
  endpoint_domain_prefix          = var.app_name
  load_balancer_arn               = module.ecs.alb_arn
  load_balancer_listener_port     = 443
  load_balancer_listener_protocol = "https"
  subnet_ids                      = module.vpc.private_subnets
  security_group_ids              = [module.verified_access_sg.security_group_id]
  verified_access_group_id        = module.verified_access.va_group_id

  depends_on = [
    module.ram
  ]
}

module "route53_records" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"
  providers = {
    aws = aws.app
  }

  zone_id = var.hosted_zone_id

  records = [
    {
      name    = var.app_name
      type    = "CNAME"
      ttl     = 5
      records = [module.verified_access_endpoint.verifiedaccess_endpoint_domain]
    }
  ]
}
