# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31"
    }
  }
}

provider "aws" {
  profile = var.cli_profile_name_va
  region  = var.region
  default_tags {
    tags = {
      created_by = "terraform"
    }
  }
}

provider "aws" {
  alias   = "app"
  profile = var.cli_profile_name_app
  region  = var.region
  default_tags {
    tags = {
      created_by = "terraform"
    }
  }
}
