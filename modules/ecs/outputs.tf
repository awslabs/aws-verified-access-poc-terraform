# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "ecs_task_role_arn" {
  value = module.ecs_task_role.iam_role_arn
}

output "ecs_cluster_arn" {
  value = module.ecs_cluster.ecs_cluster_arn
}

output "alb_id" {
  value = module.alb.lb_id
}

output "alb_arn" {
  value = module.alb.lb_arn
}
