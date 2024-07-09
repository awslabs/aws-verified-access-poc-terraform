# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ecs_task_role_custom_iam_policy_document" {
  #checkov:skip=CKV_AWS_111:IAM Resource Constraints To Be Addressed
  statement {
    sid = "SQSPermission"
    actions = [
      "sqs:Publish",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "CreateLogGroupPermission"
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups",
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:CreateLogGroup"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid = "ECSExecSSM"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }

  statement {
    sid       = "ECSExecKMS"
    actions   = ["kms:Decrypt"]
    resources = ["arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"]
  }
}

data "aws_iam_policy_document" "ecs_task_execution_role_custom_iam_policy_document" {
  #checkov:skip=CKV_AWS_111:IAM Resource Constraints To Be Addressed
  statement {
    sid    = "CreateLogGroupPermission"
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups",
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:CreateLogGroup"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "cloudwatch_logs_allow_kms" {
  #checkov:skip=CKV_AWS_109:IAM Resource Constraints To Be Addressed
  #checkov:skip=CKV_AWS_111:IAM Resource Constraints To Be Addressed
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "kms:*",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "Allow logs KMS access"
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        format(
          "logs.%s.amazonaws.com",
          data.aws_region.current.name
        )
      ]
    }

    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]
  }
}
