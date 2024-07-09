# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

data "terraform_remote_state" "prereqs" {
  backend = "local"
  config  = { path = "./prereqs/terraform.tfstate" }
}

data "aws_organizations_organization" "org" {}
