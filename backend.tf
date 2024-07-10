# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

terraform {
  backend "s3" {
    region         = "us-west-2"
    encrypt        = true
    bucket         = "tfstate-us-west-2-502191026122-ava-app1"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform-locking-ava-app1"
  }
}
