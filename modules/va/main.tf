# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "aws_verifiedaccess_trust_provider" "provider" {
  description              = "${var.app_name} trust provider"
  policy_reference_name    = var.policy_reference_name
  trust_provider_type      = "user"
  user_trust_provider_type = "iam-identity-center"
  tags = {
    Name = "IAM"
  }
}

resource "aws_verifiedaccess_instance" "instance" {
  description = "${var.app_name} instance"
  tags = {
    Name = var.app_name
  }
}

resource "aws_verifiedaccess_group" "group" {
  verifiedaccess_instance_id = aws_verifiedaccess_instance.instance.id
  policy_document            = var.policy_document
  tags = {
    Name = var.app_name
  }

  depends_on = [
    aws_verifiedaccess_instance_trust_provider_attachment.attachment
  ]
}

resource "aws_verifiedaccess_instance_trust_provider_attachment" "attachment" {
  verifiedaccess_instance_id       = aws_verifiedaccess_instance.instance.id
  verifiedaccess_trust_provider_id = aws_verifiedaccess_trust_provider.provider.id
}
