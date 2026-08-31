variable "aws_region" {
  description = "AWS region used by the EKS platform."
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Project name used for resource naming and tags."
  type        = string
  default     = "FRHN-Portal"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "prod"
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Pinned EKS Kubernetes version."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block assigned to the EKS VPC."
  type        = string
}

variable "public_subnets" {
  description = "Public subnet definitions used by the internet-facing load balancer."
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Private subnet definitions used by EKS managed nodes."
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "node_instance_types" {
  description = "EC2 instance types used by the managed node group."
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired number of worker nodes."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 3
}

variable "tags" {
  description = "Additional tags applied to platform resources."
  type        = map(string)
  default     = {}
}

variable "notification_email" {
  description = "Email address that receives EKS pod-health alerts."
  type        = string
}
