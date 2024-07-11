# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

locals {
  app_account_id = var.single_account ? var.ava_account_id : var.app_account_id
}

data "aws_iam_policy_document" "verified_access_policy" {
  statement {
    sid = "RequiresWildcard"

    # The following actions only support the all resources wildcard (*)
    actions = [
      "ec2:DescribeVerifiedAccessGroups",
      "ec2:DescribeVerifiedAccessInstances",
      "ec2:DescribeVerifiedAccessTrustProviders",
      "organizations:Describe*",
      "organizations:ListAccounts",
      "organizations:ListAWSServiceAccessForOrganization",
      "organizations:ListRoots",
      "verified-access:AllowVerifiedAccess",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "ManageEc2"

    actions = [
      "ec2:AttachVerifiedAccessTrustProvider",
      "ec2:CreateTags",
      "ec2:CreateVerifiedAccessGroup",
      "ec2:CreateVerifiedAccessInstance",
      "ec2:CreateVerifiedAccessTrustProvider",
      "ec2:DeleteTags",
      "ec2:DeleteVerifiedAccessGroup",
      "ec2:DeleteVerifiedAccessInstance",
      "ec2:DeleteVerifiedAccessTrustProvider",
      "ec2:DetachVerifiedAccessTrustProvider",
      "ec2:GetVerifiedAccessGroupPolicy",
      "ec2:ModifyVerifiedAccessGroup",
      "ec2:ModifyVerifiedAccessInstance",
      "sso:DescribeInstance",

    ]

    resources = [
      "arn:aws:ec2:${var.region}:${var.ava_account_id}:verified-access-group/*",
      "arn:aws:ec2:${var.region}:${var.ava_account_id}:verified-access-instance/*",
      "arn:aws:ec2:${var.region}:${var.ava_account_id}:verified-access-trust-provider/*",
      "arn:aws:sso:::instance/ssoins-*",
    ]
  }
}

data "aws_iam_policy_document" "ram_policy" {
  statement {
    sid = "ManageRAM"

    actions = [
      "ec2:DeleteResourcePolicy",
      "ec2:ModifyVerifiedAccessGroupPolicy",
      "ec2:PutResourcePolicy",
      "iam:CreateServiceLinkedRole",
      "organizations:DescribeOrganization",
      "organizations:EnableAWSServiceAccess",
      "ram:AssociateResourceShare",
      "ram:AssociateResourceSharePermission",
      "ram:CreateResourceShare",
      "ram:DeleteResourceShare",
      "ram:DisassociateResourceShare",
      "ram:DisssociateResourceSharePermission",
      "ram:Get*",
      "ram:List*",
      "ram:TagResource",
      "ram:UntagResource",
      "ram:UpdateResourceShare",
    ]

    resources = [
      "arn:aws:ec2:${var.region}:${var.ava_account_id}:verified-access-group/*",
      "arn:aws:organizations::${var.ava_account_id}:organization/*",
      "arn:aws:ram:${var.region}:${var.ava_account_id}:*/*",
    ]
  }
}

data "aws_iam_policy_document" "app_policy" {
  statement {
    sid = "RequiresWildcard"

    # The following actions only support the all resources wildcard (*)
    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAddressesAttribute",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNatGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroupRules",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVerifiedAccessEndpoints",
      "ec2:DescribeVpcs",
      "ecs:DeregisterTaskDefinition",
      "ecs:DescribeTaskDefinition",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetGroups",
      "kms:CreateKey",
      "logs:DescribeLogGroups",
      "route53:ListHostedZones",
      "signin:ListTrustedIdentityPropagationApplicationForConsole",
      "sso:GetManagedApplicationInstance",
      "sso:GetSharedSsoConfiguration",
      "sso:GetSsoStatus",
      "sso:ListApplications",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "ManageApp"

    actions = [
      "acm:AddTagsToCertificate",
      "acm:DeleteCertificate",
      "acm:Describe*",
      "acm:DescribeCertificate",
      "acm:GetCertificate",
      "acm:List*",
      "acm:RemoveTagsFromCertificate",
      "acm:RequestCertificate",
      "application-autoscaling:DeleteScalingPolicy",
      "application-autoscaling:DeregisterScalableTarget",
      "application-autoscaling:Describe*",
      "application-autoscaling:ListTagsForResource",
      "application-autoscaling:PutScalingPolicy",
      "application-autoscaling:RegisterScalableTarget",
      "application-autoscaling:TagResource",
      "application-autoscaling:UntagResource",
      "ec2:*VerifiedAccess*",
      "ec2:*VerifiedAccess*",
      "ec2:AllocateAddress",
      "ec2:AssociateAddress",
      "ec2:AssociateRouteTable",
      "ec2:AssociateVpcCidrBlock",
      "ec2:AttachInternetGateway",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateInternetGateway",
      "ec2:CreateNatGateway",
      "ec2:CreateNetworkAcl",
      "ec2:CreateNetworkAclEntry",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSubnet",
      "ec2:CreateTags",
      "ec2:CreateVpc",
      "ec2:DeleteInternetGateway",
      "ec2:DeleteNatGateway",
      "ec2:DeleteNetworkAcl",
      "ec2:DeleteNetworkAclEntry",
      "ec2:DeleteRoute",
      "ec2:DeleteRouteTable",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSubnet",
      "ec2:DeleteTags",
      "ec2:DeleteVpc",
      "ec2:Describe*",
      "ec2:DetachInternetGateway",
      "ec2:DisassociateAddress",
      "ec2:DisassociateRouteTable",
      "ec2:DisassociateVpcCidrBlock",
      "ec2:Get*",
      "ec2:ModifyVpcAttribute",
      "ec2:ReleaseAddress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ecs:CreateCluster",
      "ecs:CreateService",
      "ecs:CreateTaskSet",
      "ecs:DeleteCluster",
      "ecs:DeleteService",
      "ecs:DeleteTaskSet",
      "ecs:Describe*",
      "ecs:List*",
      "ecs:PutClusterCapacityProviders",
      "ecs:RegisterTaskDefinition",
      "ecs:TagResource",
      "ecs:UntagResoruce",
      "ecs:UpdateService",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:RemoveTags",
      "elasticloadbalancing:RemoveTags",
      "iam:*Policy",
      "iam:*Role",
      "iam:*RolePolicy",
      "iam:CreateServiceLinkedRole",
      "iam:Get*",
      "iam:List*",
      "kms:*Key*",
      "kms:Describe*",
      "kms:Get*",
      "kms:List*",
      "kms:TagResource",
      "kms:UntagResource",
      "logs:CreateLogGroup",
      "logs:DeleteLogGroup",
      "logs:DeleteRetentionPolicy",
      "logs:Describe*",
      "logs:List*",
      "logs:PutRetentionPolicy",
      "logs:Tag*",
      "logs:Untag*",
      "route53:ChangeResourceRecordSets",
      "route53:GetChange",
      "route53:GetHostedZone",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
      "signin:CreateTrustedIdentityPropagationApplicationForConsole",
      "sso:CreateApplication",
      "sso:CreateManagedApplicationInstance",
      "sso:GetApplicationAssignmentConfiguration",
      "sso:DeleteManagedApplicationInstance",
      "sso:PutApplicationAccessScope",
      "sso:PutApplicationAssignmentConfiguration",
      "sso:PutApplicationAuthenticationMethod",
      "sso:PutApplicationGrant",
      "sso:UpdateManagedApplicationInstance",
    ]

    resources = [
      "arn:aws:acm:${var.region}:${local.app_account_id}:certificate/*",
      "arn:aws:application-autoscaling:${var.region}:${local.app_account_id}:scalable-target/*",
      "arn:aws:ec2:${var.region}:${local.app_account_id}:*/*",
      "arn:aws:ec2:${var.region}:${local.app_account_id}:natgateway/*",
      "arn:aws:ec2:${var.region}:${var.ava_account_id}:verified-access-group/vagr-*",
      "arn:aws:ecs:${var.region}:${local.app_account_id}:cluster/ecs-${var.app_name}",
      "arn:aws:ecs:${var.region}:${local.app_account_id}:service/ecs-${var.app_name}/${var.app_name}-application",
      "arn:aws:ecs:${var.region}:${local.app_account_id}:task-definition/taskdef-${var.app_name}-application:*",
      "arn:aws:elasticloadbalancing:${var.region}:${local.app_account_id}:listener/app/alb-${var.app_name}/*",
      "arn:aws:elasticloadbalancing:${var.region}:${local.app_account_id}:loadbalancer/app/alb-${var.app_name}/*",
      "arn:aws:elasticloadbalancing:${var.region}:${local.app_account_id}:targetgroup/tg-alb-${var.app_name}-app/*",
      "arn:aws:iam::${local.app_account_id}:policy/ava*",
      "arn:aws:iam::${local.app_account_id}:role/ava*",
      "arn:aws:iam::${local.app_account_id}:role/aws-service-role/verified-access.amazonaws.com/AWSServiceRoleForVPCVerifiedAccess",
      "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
      "arn:aws:kms:${var.region}:${local.app_account_id}:key/*",
      "arn:aws:logs:${var.region}:${local.app_account_id}:log-group:/aws/ecs/ecs-${var.app_name}:log-stream:",
      "arn:aws:logs:${var.region}:${local.app_account_id}:log-group:/aws/ecs/ecs-${var.app_name}",
      "arn:aws:route53:::change/*",
      "arn:aws:route53:::hostedzone/*",
      "arn:aws:sso:::instance/ssoins-*",
      "arn:aws:sso::${var.ava_account_id}:application/*/*",
      "arn:aws:sso::aws:applicationProvider/verified-access",
    ]
  }
}
