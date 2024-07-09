# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# Create IAM role to configure the application
resource "aws_iam_role" "app_role" {
  count    = var.single_account ? 0 : 1
  provider = aws.app
  name     = "ava_app_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${var.app_account_id}:root"
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

resource "aws_iam_policy" "app_policy" {
  count = var.single_account ? 0 : 1

  provider = aws.app
  path     = "/"
  name     = "ava_app_policy"

  policy = data.aws_iam_policy_document.app_policy.json
}

resource "aws_iam_role_policy_attachment" "app_policy_attachment" {
  count = var.single_account ? 0 : 1

  provider   = aws.app
  role       = aws_iam_role.app_role[0].name
  policy_arn = aws_iam_policy.app_policy[0].arn
}
