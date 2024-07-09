# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# Create an S3 bucket to store TF state
resource "aws_s3_bucket" "state_bucket" {
  #checkov:skip=CKV_AWS_18:Access logging not required for POC
  #checkov:skip=CKV_AWS_144:CRR required for POC
  #checkov:skip=CKV_AWS_145:Bucket encrypted as separate resource
  bucket        = "${var.s3_tfstate_bucket_prefix}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}-${var.app_name}"
  force_destroy = true
  tags = {
    Terraform = "true"
  }
}

resource "aws_s3_bucket_versioning" "state_bucket_versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket_encrypt" {
  bucket = aws_s3_bucket.state_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "state_bucket_acl" {
  bucket     = aws_s3_bucket.state_bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.state_bucket_acl_ownership]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "state_bucket_acl_ownership" {
  #checkov:skip=CKV2_AWS_65:Bucket ACL designated "private"
  bucket = aws_s3_bucket.state_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "state-block-public" {
  bucket = aws_s3_bucket.state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Create a DynamoDB table to use for terraform state locking
resource "aws_dynamodb_table" "tf_lock_state" {
  #checkov:skip=CKV_AWS_28:Point in time recovery not required for POC
  #checkov:skip=CKV_AWS_119:CMK not required for POC
  name = "${var.dynamo_db_table_prefix}-${var.app_name}"

  # Pay per request is cheaper for low-i/o applications, like our TF lock state
  billing_mode = "PAY_PER_REQUEST"

  # Hash key is required, and must be an attribute
  hash_key = "LockID"

  # Attribute LockID is required for TF to use this table for lock state
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name      = "${var.dynamo_db_table_prefix}-${var.app_name}"
    Terraform = "true"
  }
}
