# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# Create IAM role to configure Verified Access
resource "aws_iam_role" "verified_access_role" {
  name = "ava_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${var.ava_account_id}:root"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Terraform = "true"
  }
}

resource "aws_iam_policy" "verified_access_policy" {
  name   = "ava_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.verified_access_policy.json
}

resource "aws_iam_role_policy_attachment" "verified_access_policy_attachment" {
  role       = aws_iam_role.verified_access_role.name
  policy_arn = aws_iam_policy.verified_access_policy.arn
}

# Create IAM role to configure the application
resource "aws_iam_role" "app_role_single" {
  count = var.single_account ? 1 : 0
  name  = "ava_app_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${var.ava_account_id}:root"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Terraform = "true"
  }
}

resource "aws_iam_policy" "app_policy_single" {
  count = var.single_account ? 1 : 0

  name   = "ava_app_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.app_policy.json
}

resource "aws_iam_role_policy_attachment" "app_policy_attachment_single" {
  count      = var.single_account ? 1 : 0
  role       = aws_iam_role.app_role_single[0].name
  policy_arn = aws_iam_policy.app_policy_single[0].arn
}

resource "aws_iam_policy" "ram_policy" {
  count = var.single_account ? 0 : 1
  path  = "/"
  name  = "ava_ram_policy"

  policy = data.aws_iam_policy_document.ram_policy.json
}
resource "aws_iam_role_policy_attachment" "ram_policy_attachment" {
  count      = var.single_account ? 0 : 1
  role       = aws_iam_role.verified_access_role.name
  policy_arn = aws_iam_policy.ram_policy[0].arn
}
