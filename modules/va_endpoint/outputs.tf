# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "verifiedaccess_endpoint_domain" {
  value = aws_verifiedaccess_endpoint.access_endpoint.endpoint_domain
}
