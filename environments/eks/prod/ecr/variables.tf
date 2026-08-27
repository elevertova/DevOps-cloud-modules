variable "aws_region" {
  description = "AWS region used by the ECR repository."
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Project name used in tags."
  type        = string
  default     = "FRHN-Portal"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "prod"
}

variable "repository_name" {
  description = "Name of the reusable ECR repository."
  type        = string
}

variable "tags" {
  description = "Additional tags applied to ECR resources."
  type        = map(string)
  default     = {}
}
