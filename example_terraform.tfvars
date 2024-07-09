# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# Update the following variables per your use case
# Rename the file to `terraform.tfvars` so these values
# can be used during deployment

region      = "us-west-2"
environment = "dev"
app_name    = "ava-app1"

# The Route 53 public hosted zone is not created as part of the Terraform code
# To add records to the zone, the zone must be in the same account as the ECS application
hosted_zone_id   = "Z0750347GU4FHEXAMPLE"
hosted_zone_name = "example.com"

# The VPC will be created using the following CIDR configuration
# This is more than enough IP addresses for this POC, but
# if you plan to scale out your POC, make sure modify these
# values to meet your needs.
vpc_config = {
  azs              = ["us-west-2a", "us-west-2b"]
  cidr             = ["10.0.0.0/24"]
  public_subnets   = ["10.0.0.0/28", "10.0.0.16/28"]
  private_subnets  = ["10.0.0.32/28", "10.0.0.48/28"]
  database_subnets = ["10.0.0.64/28", "10.0.0.80/28"]
}
