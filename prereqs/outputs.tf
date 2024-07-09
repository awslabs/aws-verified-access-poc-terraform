# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# Output resource info for Terraform state

output "backend_region" {
  value = var.region
}

output "s3_tfstate_bucket_name" {
  value = aws_s3_bucket.state_bucket.bucket
}

output "bucket_key" {
  value = var.app_name
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.tf_lock_state.name
}

output "verified_access_role" {
  value = aws_iam_role.verified_access_role.arn
}

output "app_role" {
  value = var.single_account ? aws_iam_role.app_role_single[0].arn : aws_iam_role.app_role[0].arn
}

output "single_account" {
  value = var.single_account
}

output "cli_profile_name_va" {
  value = var.cli_profile_name_va
}

output "cli_profile_name_app" {
  value = var.single_account ? var.cli_profile_name_va : var.cli_profile_name_app
}
