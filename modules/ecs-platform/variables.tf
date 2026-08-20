# Input variables for the reusable Amazon ECS Fargate platform module.
# Environment configurations provide networking, capacity, image, and HTTPS values.

variable "name_prefix" {
  description = "Prefix used when naming ECS platform resources."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the ALB and ECS service are deployed."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs used by the internet-facing load balancer."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "At least two public subnets are required."
  }
}

variable "task_subnet_ids" {
  description = "Subnet IDs used by the ECS Fargate tasks."
  type        = list(string)

  validation {
    condition     = length(var.task_subnet_ids) >= 2
    error_message = "At least two task subnets are required."
  }
}

variable "assign_public_ip" {
  description = "Whether ECS tasks receive public IP addresses."
  type        = bool
  default     = false
}

variable "container_image" {
  description = "Complete ECR image URI and tag used by the ECS task."
  type        = string
}

variable "container_name" {
  description = "Name of the application container."
  type        = string
  default     = "frhn-portal"
}

variable "container_port" {
  description = "Port exposed by the application container."
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
  description = "Initial number of ECS tasks maintained by the service."
  type        = number
  default     = 1
}

variable "minimum_capacity" {
  description = "Minimum number of tasks maintained by auto scaling."
  type        = number
  default     = 1
}

variable "maximum_capacity" {
  description = "Maximum number of tasks allowed by auto scaling."
  type        = number
  default     = 2
}

variable "target_cpu_utilization" {
  description = "Average CPU percentage that triggers target-tracking scaling."
  type        = number
  default     = 60
}

variable "health_check_path" {
  description = "HTTP path used by the ALB to check container health."
  type        = string
  default     = "/"
}

variable "health_check_grace_period_seconds" {
  description = "Time allowed for a new task to start before ECS evaluates health."
  type        = number
  default     = 60
}

variable "log_retention_days" {
  description = "Number of days CloudWatch retains container logs."
  type        = number
  default     = 7
}

variable "certificate_arn" {
  description = "Optional ACM certificate ARN used by the HTTPS listener."
  type        = string
  default     = null
  nullable    = true
}

variable "alb_ingress_cidrs" {
  description = "IPv4 CIDR ranges permitted to reach the public ALB."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "environment_variables" {
  description = "Non-sensitive environment variables passed to the container."
  type        = map(string)
  default     = {}
}

variable "enable_container_insights" {
  description = "Whether CloudWatch Container Insights is enabled for the cluster."
  type        = bool
  default     = true
}

variable "enable_execute_command" {
  description = "Whether ECS Exec is enabled for controlled troubleshooting."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to ECS platform resources."
  type        = map(string)
  default     = {}
}