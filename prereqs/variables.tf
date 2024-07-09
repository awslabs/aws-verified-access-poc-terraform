# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "region" {
  description = "AWS region for deployment"
  type        = string
}

variable "single_account" {
  description = "Boolean to set account deployment strategy"
  type        = bool
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "s3_tfstate_bucket_prefix" {
  description = "Name of the S3 bucket used for Terraform state storage"
  type        = string
}

variable "dynamo_db_table_prefix" {
  description = "Name of DynamoDB table used for Terraform locking"
  type        = string
}

variable "cli_profile_name_va" {
  description = "CLI profile name to use for account access"
  type        = string
  default     = ""
}

variable "ava_account_id" {
  description = "Account ID where AWS IAM Identity Center is enabled"
  type        = string
  default     = ""
}

variable "cli_profile_name_app" {
  description = "CLI profile name to use for account access"
  type        = string
  default     = ""
}

variable "app_account_id" {
  description = "# Account ID where the application will live"
  type        = string
  default     = ""
}
