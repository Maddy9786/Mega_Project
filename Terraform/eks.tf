module "eks" {
  source             = "terraform-aws-modules/eks/aws"
  version            = "~> 21.0"
  name               = local.name
  kubernetes_version = var.kubernetes_version

  # Optional
  endpoint_public_access  = true # allows internet to access the API server
  endpoint_private_access = true # with this interal service can communicate with private VPC endpoint

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  # EKS Add-ons (latest versions auto-resolved)
  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
    }
    eks-pod-identity-agent = {
      most_recent    = true
      before_compute = true
    }
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_irsa.iam_role_arn
    }
    metrics-server = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id

  subnet_ids               = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets


  eks_managed_node_groups = {
    Bankapp_ng = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      instance_types = [var.node_instance_type]
      min_size       = var.node_min_count
      max_size       = var.node_max_count
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = var.node_desired_count

      tags = {
        NodeGroup = "bankapp"
      }
    }
  }
  tags = local.tags
}

# IRSA for EBS CSI Driver (needed to create/attach EBS volumes)
module "ebs_csi_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name             = "${local.name}-ebs-csi"
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = local.tags
}


