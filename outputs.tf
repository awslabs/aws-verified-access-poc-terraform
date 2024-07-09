# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "app_url" {
  value = "https://${local.app_fqdn}"
}
