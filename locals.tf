# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

locals {
  prereqs_out = data.terraform_remote_state.prereqs.outputs
  app_fqdn    = module.route53_records.route53_record_fqdn["${var.app_name} CNAME"]
}
