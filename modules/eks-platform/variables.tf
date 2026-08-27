variable "cluster_name" {
  description = "Name of the Amazon EKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Pinned Kubernetes control-plane version."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by the cluster and managed nodes."
  type        = list(string)
}

variable "node_instance_types" {
  description = "EC2 instance types available to the managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired managed-node count."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum managed-node count."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum managed-node count."
  type        = number
  default     = 3
}

variable "tags" {
  description = "Tags applied to EKS resources."
  type        = map(string)
  default     = {}
}
