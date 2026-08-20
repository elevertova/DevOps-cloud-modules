# Production environment values for the FRHN ECS platform.

aws_region   = "us-west-2"
project_name = "FRHN-Portal"
environment  = "prod"

vpc_cidr = "10.2.0.0/16"

public_subnets = {
  a = {
    cidr = "10.2.1.0/24"
    az   = "us-west-2a"
  }
  b = {
    cidr = "10.2.2.0/24"
    az   = "us-west-2b"
  }
}

private_subnets = {
  a = {
    cidr = "10.2.11.0/24"
    az   = "us-west-2a"
  }
  b = {
    cidr = "10.2.12.0/24"
    az   = "us-west-2b"
  }
}

enable_nat_gateway       = true
use_private_task_subnets = true

repository_name         = "frhn-prod-portal"
image_tag               = "prod-v1"
image_tag_mutability    = "IMMUTABLE"
force_delete_repository = true

container_port = 80
task_cpu       = 256
task_memory    = 512

desired_count          = 2
minimum_capacity       = 2
maximum_capacity       = 4
target_cpu_utilization = 60

log_retention_days = 30

certificate_arn = null
domain_name     = "portal.mycloudlab.space"

alb_ingress_cidrs = ["0.0.0.0/0"]

enable_container_insights = true
enable_execute_command    = false

tags = {
  OwnerTeam          = "FRHN-CloudEngineers"
  Application        = "FRHN-Portal"
  Workload           = "Web-Portal"
  DataClassification = "Demo"
}