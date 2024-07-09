# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "aws_verifiedaccess_endpoint" "access_endpoint" {
  description        = "${var.app_name} access endpoint"
  application_domain = var.application_domain

  verified_access_group_id = var.verified_access_group_id

  attachment_type        = "vpc"
  domain_certificate_arn = var.domain_certificate_arn
  endpoint_domain_prefix = var.endpoint_domain_prefix
  endpoint_type          = "load-balancer"
  load_balancer_options {
    load_balancer_arn = var.load_balancer_arn
    port              = var.load_balancer_listener_port
    protocol          = var.load_balancer_listener_protocol
    subnet_ids        = var.subnet_ids
  }

  security_group_ids = var.security_group_ids

  tags = {
    Name = var.app_name
  }
}
