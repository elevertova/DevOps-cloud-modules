output "cluster_name" {
  description = "Name used by aws eks update-kubeconfig."
  value       = module.eks_platform.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Kubernetes API endpoint."
  value       = module.eks_platform.cluster_endpoint
}

output "node_group_name" {
  description = "EKS managed node-group name."
  value       = module.eks_platform.node_group_name
}

output "vpc_id" {
  description = "Dedicated EKS VPC ID."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs available to the load balancer."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs used by managed worker nodes."
  value       = module.vpc.private_subnet_ids
}

output "kubeconfig_command" {
  description = "Command that configures kubectl after the cluster is Active."
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks_platform.cluster_name} --profile AdministratorAccess-330907589313"
}
