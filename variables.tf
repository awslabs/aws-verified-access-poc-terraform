# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "region" {
  description = "AWS primary region"
  type        = string
}

variable "environment" {
  description = "SDLC Stage"
  type        = string
}

variable "app_name" {
  description = "URL for accessing app"
  type        = string
}

variable "hosted_zone_id" {
  description = "Existing Route53 Public Hosted Zone ID"
  type        = string
}

variable "hosted_zone_name" {
  description = "Existing Route53 Public Hosted Zone Name"
  type        = string
}

variable "vpc_config" {
  description = "Contains CIDR and subnet settings"
  type        = map(list(string))
  default = {
    azs             = []
    cidr            = []
    public_subnets  = []
    private_subnets = []
  }
}
