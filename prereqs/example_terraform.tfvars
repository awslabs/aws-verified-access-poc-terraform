# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# backend prereqs
region                   = "us-west-2"
app_name                 = "ava-app1"
s3_tfstate_bucket_prefix = "tfstate"
dynamo_db_table_prefix   = "terraform-locking"

# THE CONFIGURATION BELOW DETERMINES THE LOCATION OF RESOURCES
# VERIFIED ACCESS MUST BE CONFIGURED IN THE ACCOUNT THAT MANAGES IAM IDENTITY CENTER (IDC)
# OPTION 1: THE APPLICATION RESOURCES ARE IN THE SAME ACCOUNT AS IDC/VERIFIED ACCESS
# OPTION 2: THE APPLICATION RESOURCES ARE IN A DIFFERENT ACCOUNT

# For OPTION 1, set single_account = true. Only [VERIFIED ACCESS] block is required
# For OPTION 2, set single_account = false. Both blocks are required

single_account = true

# In the multi-account configuration, the Terraform creates resources in each account
# The usual and recommended way to authenticate to AWS when using Terraform is via the AWS CLI
# The prescribed method shown here is to assume a role using an existing CLI profile
# If another authentication method is used, the configuration will need to be modified for each
# provider in the `providers.tf` file

# [VERIFIED ACCESS] account specific info
cli_profile_name_va = "profile1"     # CLI profile name used to authenticate to the account where AWS IAM Identity Center is enabled
ava_account_id      = "012345678901" # Account ID where AWS IAM Identity Center is enabled

# [APPLICATION] account specific info
cli_profile_name_app = "profile2"     # CLI profile name used to authenticate to the account where the application will live (if different than above)
app_account_id       = "012345678901" # Account ID where the application will live (if different than above)
