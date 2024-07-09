# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "app_name" {
  type = string
}

variable "application_domain" {
  type = string
}

variable "domain_certificate_arn" {
  type = string
}

variable "endpoint_domain_prefix" {
  type = string
}

variable "load_balancer_arn" {
  type = string
}

variable "load_balancer_listener_port" {
  type = number
}

variable "subnet_ids" {
  type = list(string)
}

variable "load_balancer_listener_protocol" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "verified_access_group_id" {
  type = string
}
