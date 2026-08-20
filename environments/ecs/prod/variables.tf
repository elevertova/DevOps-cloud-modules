# Defines environment-specific inputs for the FRHN ECS platform.
# The same variable structure is reused by Dev, UAT, and Prod.

variable "aws_region" {
  description = "AWS region used by the environment."
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string
  default     = "FRHN-Portal"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string

  validation {
    condition     = contains(["dev", "uat", "prod"], var.environment)
    error_message = "environment must be dev, uat, or prod."
  }
}

variable "vpc_cidr" {
  description = "CIDR range assigned to the environment VPC."
  type        = string
}

variable "public_subnets" {
  description = "Public subnet definitions for the Application Load Balancer."
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Private subnet definitions for ECS Fargate tasks."
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "enable_nat_gateway" {
  description = "Whether private subnets receive outbound access through a NAT Gateway."
  type        = bool
  default     = true
}

variable "use_private_task_subnets" {
  description = "Whether ECS tasks run in private rather than public subnets."
  type        = bool
  default     = true
}

variable "repository_name" {
  description = "Name of the environment's Amazon ECR repository."
  type        = string
}

variable "image_tag" {
  description = "Docker image tag deployed by the ECS service."
  type        = string
}

variable "image_tag_mutability" {
  description = "Whether an existing ECR image tag can be overwritten."
  type        = string
  default     = "IMMUTABLE"
}

variable "force_delete_repository" {
  description = "Whether Terraform may delete the ECR repository when images remain."
  type        = bool
  default     = false
}

variable "container_port" {
  description = "Port exposed by the FRHN portal container."
  type        = number
  default     = 80
}

variable "task_cpu" {
  description = "CPU units allocated to each Fargate task."
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory in MiB allocated to each Fargate task."
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Initial number of running ECS tasks."
  type        = number
  default     = 1
}

variable "minimum_capacity" {
  description = "Minimum task count used by ECS auto scaling."
  type        = number
  default     = 1
}

variable "maximum_capacity" {
  description = "Maximum task count used by ECS auto scaling."
  type        = number
  default     = 2
}

variable "target_cpu_utilization" {
  description = "Average CPU percentage targeted by ECS auto scaling."
  type        = number
  default     = 60
}

variable "log_retention_days" {
  description = "Number of days CloudWatch retains application logs."
  type        = number
  default     = 7
}

variable "certificate_arn" {
  description = "Optional ACM certificate ARN for the HTTPS listener."
  type        = string
  default     = null
  nullable    = true
}

variable "domain_name" {
  description = "Optional custom DNS name assigned to the environment."
  type        = string
  default     = null
  nullable    = true
}

variable "alb_ingress_cidrs" {
  description = "IPv4 CIDR ranges allowed to access the public ALB."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_container_insights" {
  description = "Whether CloudWatch Container Insights is enabled."
  type        = bool
  default     = true
}

variable "enable_execute_command" {
  description = "Whether ECS Exec is enabled for controlled troubleshooting."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags applied to environment resources."
  type        = map(string)
  default     = {}
}