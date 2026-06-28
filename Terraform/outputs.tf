output "cluster_endpoint" {
  description = "This gives Cluster_Endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "This gives VPC_Endpoint"
  value       = module.eks.cluster_name
}

output "cluster_version" {
  description = "This gives VPC_Endpoint"
  value       = module.eks.cluster_version
}

output "cluster_certificate_authority_data" {
  description = "base64 encoded cluster certificate authority"
  value       = module.eks.cluster_version
  sensitive   = true
}

output "oidc_provider_arn" {
  description = "OIDC provide ARN"
  value       = module.eks.oidc_provider_arn
}

output "vpc_id" {
  description = "provide VPC ID"
  value       = module.vpc.default_vpc_id
}

output "public_subnets" {
  description = "provide details of public subnet"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "provide details of private subnet"
  value       = module.vpc.private_subnets
}

output "configure_kubectl" {
  description = "prepare a kubectl command to access the node"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${local.region}"
}

output "argocd_initial_password" {
  description = "command to retrive argocd initial password"
  value       = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
}
