# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

module "ecs_cluster" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "SPHTech-Platform/ecs/aws"
  version = "~> 0.2.8"

  name                   = var.app_name
  launch_type            = "FARGATE"
  platform_version       = "1.4.0"
  create_launch_template = false

  service_map             = local.service_map
  service_subnets         = var.private_subnets
  service_security_groups = [module.ecs_service_sg.security_group_id]
  assign_public_ip        = false

  enable_execute_command = true

  service_task_execution_role_arn = module.ecs_task_execution_role.iam_role_arn
  service_task_role_arn           = module.ecs_task_role.iam_role_arn
}
