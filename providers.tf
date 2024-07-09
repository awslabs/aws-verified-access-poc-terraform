# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55"
    }
  }
}

provider "aws" {
  profile = local.prereqs_out.cli_profile_name_va
  region  = var.region
  assume_role {
    role_arn = local.prereqs_out.verified_access_role
  }
  default_tags {
    tags = {
      created_by  = "Terraform"
      environment = var.environment
      application = var.app_name
    }
  }
}

provider "aws" {
  alias   = "app"
  profile = local.prereqs_out.cli_profile_name_app
  region  = var.region
  assume_role {
    role_arn = local.prereqs_out.app_role
  }
  default_tags {
    tags = {
      created_by  = "Terraform"
      environment = var.environment
      application = var.app_name
    }
  }
}
