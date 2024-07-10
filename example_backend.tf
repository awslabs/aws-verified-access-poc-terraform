# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# terraform {
#   backend "s3" {
#     region         = "<region>"
#     encrypt        = true
#     bucket         = "<bucket_name_for_tf_state>" # should match name defined in prereqs deployment
#     key            = "terraform.tfstate"
#     dynamodb_table = "<table_name_for_tf_state_locking>" # should match name defined in prereqs deployment
#   }
# }
