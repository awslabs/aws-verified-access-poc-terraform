# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "aws_ram_resource_share" "resource_share" {
  name = "${var.app_name}-resource-share"
}

resource "aws_ram_principal_association" "principal_association" {
  principal          = var.aws_org_arn
  resource_share_arn = aws_ram_resource_share.resource_share.arn
}

resource "aws_ram_resource_association" "resource_share_association" {
  resource_arn       = var.resource_arn
  resource_share_arn = aws_ram_resource_share.resource_share.arn
}
