output "cluster_name" {
  description = "Name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Kubernetes API endpoint."
  value       = aws_eks_cluster.this.endpoint
}

output "node_group_name" {
  description = "Name of the managed node group."
  value       = aws_eks_node_group.this.node_group_name
}

output "cluster_security_group_id" {
  description = "EKS-created cluster security group ID."
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}
