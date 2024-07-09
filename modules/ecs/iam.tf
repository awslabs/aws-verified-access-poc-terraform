# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

module "ecs_task_execution_role" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.13"

  create_role           = true
  role_requires_mfa     = false
  role_name             = "${var.app_name}-app-task-execution-role"
  trusted_role_services = ["ecs-tasks.amazonaws.com"]
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    module.ecs_task_execution_role_custom_iam_policy.arn
  ]
}

module "ecs_task_execution_role_custom_iam_policy" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 4.13.0"

  policy      = data.aws_iam_policy_document.ecs_task_execution_role_custom_iam_policy_document.json
  name        = "${var.app_name}-app-task-execution-custom-iam-policy"
  description = "ECS task execution custom IAM policy"
}

module "ecs_task_role" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.13"

  create_role           = true
  role_requires_mfa     = false
  role_name             = "${var.app_name}-app-task-role"
  trusted_role_services = ["ecs-tasks.amazonaws.com"]
  custom_role_policy_arns = [
    module.ecs_task_role_custom_iam_policy.arn
  ]
}

module "ecs_task_role_custom_iam_policy" {
  #checkov:skip=CKV_TF_1:Commit hash not required
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 4.13.0"

  policy      = data.aws_iam_policy_document.ecs_task_role_custom_iam_policy_document.json
  name        = "${var.app_name}-app-task-role-custom-iam-policy"
  description = "ECS task role custom IAM policy"
}
