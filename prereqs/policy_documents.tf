# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

locals {
  app_account_id = var.single_account ? var.ava_account_id : var.app_account_id
}

data "aws_iam_policy_document" "verified_access_policy" {
  statement {
    sid = "ManageVerifiedAccess"

    # The following actions only support the all resources wildcard (*)
    actions = [
      "verified-access:AllowVerifiedAccess",
      "ec2:DescribeVerifiedAccessTrustProviders",
      "ec2:DescribeVerifiedAccessInstances",
      "ec2:DescribeVerifiedAccessGroups",
      "organizations:Describe*",
      "organizations:ListAccounts",
      "organizations:ListRoots",
      "organizations:ListAWSServiceAccessForOrganization",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "ManageEc2"

    actions = [
      "sso:DescribeInstance",
      "ec2:CreateVerifiedAccessTrustProvider",
      "ec2:DeleteVerifiedAccessTrustProvider",
      "ec2:AttachVerifiedAccessTrustProvider",
      "ec2:DetachVerifiedAccessTrustProvider",
      "ec2:CreateVerifiedAccessInstance",
      "ec2:ModifyVerifiedAccessInstance",
      "ec2:DeleteVerifiedAccessInstance",
      "ec2:CreateVerifiedAccessGroup",
      "ec2:ModifyVerifiedAccessGroup",
      "ec2:DeleteVerifiedAccessGroup",
      "ec2:GetVerifiedAccessGroupPolicy",
      "ec2:CreateTags",
      "ec2:DeleteTags",

    ]

    resources = [
      "arn:aws:sso:::instance/ssoins-*",
      "arn:aws:ec2:${var.region}:${var.ava_account_id}:verified-access-instance/*",
      "arn:aws:ec2:${var.region}:${var.ava_account_id}:verified-access-trust-provider/*",
      "arn:aws:ec2:${var.region}:${var.ava_account_id}:verified-access-group/*",
    ]
  }
}

data "aws_iam_policy_document" "ram_policy" {
  statement {
    sid = "ManageRAM"

    actions = [
      "ram:List*",
      "ram:Get*",
      "ram:CreateResourceShare",
      "ram:UpdateResourceShare",
      "ram:DeleteResourceShare",
      "ram:AssociateResourceShare",
      "ram:DisassociateResourceShare",
      "ram:AssociateResourceSharePermission",
      "ram:DisssociateResourceSharePermission",
      "ram:TagResource",
      "ram:UntagResource",
      "iam:CreateServiceLinkedRole",
      "organizations:EnableAWSServiceAccess",
      "organizations:DescribeOrganization",
      "ec2:ModifyVerifiedAccessGroupPolicy",
      "ec2:PutResourcePolicy",
      "ec2:DeleteResourcePolicy",
    ]

    resources = [
      "arn:aws:ram:${var.region}:${var.ava_account_id}:*/*",
      "arn:aws:organizations::${var.ava_account_id}:organization/*",
      "arn:aws:ec2:${var.region}:${var.ava_account_id}:verified-access-group/*",
    ]
  }
}

data "aws_iam_policy_document" "app_policy" {
  statement {
    # The `*` for resources is limited to read-only actions unless
    # otherwise specified in trailing comments
    sid = "ReadInfra"

    actions = [
      "sso:GetSsoStatus",
      "sso:GetApplicationAssignmentConfiguration",
      "sso:GetManagedApplicationInstance",
      "sso:GetSharedSsoConfiguration",
      "sso:ListApplications",
      "signin:ListTrustedIdentityPropagationApplicationForConsole",
      "route53:ListHostedZones",
      "route53:GetHostedZone",
      "route53:ListTagsForResource",
      "route53:ListResourceRecordSets",
      "route53:GetChange",
      "elasticloadbalancing:Describe*",
      "kms:List*",
      "kms:Describe*",
      "kms:Get*",
      "kms:CreateKey",
      "iam:List*",
      "iam:Get*",
      "ec2:Describe*",
      "ec2:Get*",
      "ecs:Describe*",
      "ecs:List*",
      "logs:Describe*",
      "logs:List*",
      "acm:Describe*",
      "acm:List*",
      "application-autoscaling:Describe*",
      "ecs:DeregisterTaskDefinition", # This action only supports the all resources wildcard (*)
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "ManageInfra"

    actions = [
      "sso:PutApplicationAssignmentConfiguration",
      "sso:PutApplicationAuthenticationMethod",
      "sso:CreateManagedApplicationInstance",
      "sso:UpdateManagedApplicationInstance",
      "sso:DeleteManagedApplicationInstance",
      "sso:CreateApplication",
      "sso:PutApplicationGrant",
      "sso:PutApplicationAccessScope",
      "signin:CreateTrustedIdentityPropagationApplicationForConsole",
      "route53:ChangeResourceRecordSets",
      "ecs:RegisterTaskDefinition",
      "ec2:*VerifiedAccess*",
      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:CreateInternetGateway",
      "ec2:DeleteInternetGateway",
      "ec2:AttachInternetGateway",
      "ec2:DetachInternetGateway",
      "ec2:CreateRoute",
      "ec2:DeleteRoute",
      "ec2:CreateNatGateway",
      "ec2:DeleteNatGateway",
      "ec2:CreateSubnet",
      "ec2:DeleteSubnet",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:CreateNetworkAclEntry",
      "ec2:DeleteNetworkAclEntry",
      "ec2:CreateNetworkAcl",
      "ec2:DeleteNetworkAcl",
      "ec2:ModifyVpcAttribute",
      "ec2:AssociateVpcCidrBlock",
      "ec2:DisassociateVpcCidrBlock",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:CreateSecurityGroup",
      "ec2:DeleteSecurityGroup",
      "ec2:CreateRouteTable",
      "ec2:DeleteRouteTable",
      "ec2:AssociateRouteTable",
      "ec2:DisassociateRouteTable",
      "ec2:AllocateAddress",
      "ec2:ReleaseAddress",
      "ec2:DisassociateAddress",
      "ec2:AssociateAddress",
      "ec2:*VerifiedAccess*",
      "logs:Describe*",
      "logs:List*",
      "logs:CreateLogGroup",
      "logs:DeleteLogGroup",
      "logs:PutRetentionPolicy",
      "logs:DeleteRetentionPolicy",
      "logs:Tag*",
      "logs:Untag*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:*Key*",
      "iam:*Role",
      "iam:*RolePolicy",
      "iam:*Policy",
      "iam:CreateServiceLinkedRole",
      "ecs:CreateCluster",
      "ecs:DeleteCluster",
      "ecs:PutClusterCapacityProviders",
      "ecs:CreateService",
      "ecs:DeleteService",
      "ecs:UpdateService",
      "ecs:CreateTaskSet",
      "ecs:DeleteTaskSet",
      "ecs:TagResource",
      "ecs:UntagResoruce",
      "acm:RequestCertificate",
      "acm:DescribeCertificate",
      "acm:GetCertificate",
      "acm:DeleteCertificate",
      "acm:AddTagsToCertificate",
      "acm:RemoveTagsFromCertificate",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags",
      "application-autoscaling:RegisterScalableTarget",
      "application-autoscaling:DeregisterScalableTarget",
      "application-autoscaling:PutScalingPolicy",
      "application-autoscaling:DeleteScalingPolicy",
      "application-autoscaling:TagResource",
      "application-autoscaling:UntagResource",
      "application-autoscaling:ListTagsForResource",
    ]

    resources = [
      "arn:aws:sso:::instance/ssoins-*",
      "arn:aws:sso::${local.app_account_id}:application/*/*",
      "arn:aws:sso::aws:applicationProvider/verified-access",
      "arn:aws:iam::${local.app_account_id}:role/ava*",
      "arn:aws:iam::${local.app_account_id}:policy/ava*",
      "arn:aws:iam::${var.ava_account_id}:role/*",
      "arn:aws:route53:::hostedzone/*",
      "arn:aws:acm:${var.region}:${local.app_account_id}:certificate/*",
      "arn:aws:ecs:${var.region}:${local.app_account_id}:cluster/ecs-${var.app_name}",
      "arn:aws:ecs:${var.region}:${local.app_account_id}:service/ecs-${var.app_name}/${var.app_name}-application",
      "arn:aws:ecs:${var.region}:${local.app_account_id}:task-definition/taskdef-${var.app_name}-application:*",
      "arn:aws:elasticloadbalancing:${var.region}:${local.app_account_id}:loadbalancer/app/alb-${var.app_name}/*",
      "arn:aws:elasticloadbalancing:${var.region}:${local.app_account_id}:targetgroup/tg-alb-${var.app_name}-app/*",
      "arn:aws:elasticloadbalancing:${var.region}:${local.app_account_id}:listener/app/alb-${var.app_name}/*",
      "arn:aws:application-autoscaling:${var.region}:${local.app_account_id}:scalable-target/*",
      "arn:aws:ec2:${var.region}:${local.app_account_id}:*/*",
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:kms:${var.region}:${local.app_account_id}:key/*",
      "arn:aws:ec2:${var.region}:${local.app_account_id}:natgateway/*",
      "arn:aws:logs:${var.region}:${local.app_account_id}:log-group:/aws/ecs/ecs-${var.app_name}:log-stream:",
    ]
  }
}
