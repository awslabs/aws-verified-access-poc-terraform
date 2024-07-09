# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

module "app_container" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "cloudposse/ecs-container-definition/aws"
  version = "~>0.61"

  container_name  = var.app_name
  container_image = "nginx:latest"

  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-group" : "/aws/ecs/${var.app_name}",
      "awslogs-region" : "us-east-1",
      "awslogs-stream-prefix" : "aws",
      "awslogs-create-group" : "true"
    }
    secretOptions = null
  }

  port_mappings = [
    {
      "hostPort" : 80,
      "protocol" : "tcp",
      "containerPort" : 80
    }
  ]

  linux_parameters = {
    capabilities       = null,
    sharedMemorySize   = null,
    tmpfs              = null,
    devices            = null,
    maxSwap            = null,
    swappiness         = null,
    initProcessEnabled = true
  }
  mount_points = []
  environment  = var.environment_list
}
