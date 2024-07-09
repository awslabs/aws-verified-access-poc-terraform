# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "va_group_arn" {
  value = aws_verifiedaccess_group.group.verifiedaccess_group_arn
}

output "va_group_id" {
  value = aws_verifiedaccess_group.group.id
}
