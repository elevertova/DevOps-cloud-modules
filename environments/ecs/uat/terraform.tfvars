# UAT environment values for the FRHN ECS platform.

aws_region   = "us-west-2"
project_name = "FRHN-Portal"
environment  = "uat"

vpc_cidr = "10.1.0.0/16"

public_subnets = {
  a = {
    cidr = "10.1.1.0/24"
    az   = "us-west-2a"
  }
  b = {
    cidr = "10.1.2.0/24"
    az   = "us-west-2b"
  }
}

private_subnets = {
  a = {
    cidr = "10.1.11.0/24"
    az   = "us-west-2a"
  }
  b = {
    cidr = "10.1.12.0/24"
    az   = "us-west-2b"
  }
}

enable_nat_gateway       = true
use_private_task_subnets = true

repository_name         = "frhn-uat-portal"
image_tag               = "uat-v1"
image_tag_mutability    = "IMMUTABLE"
force_delete_repository = true

container_port = 80
task_cpu       = 256
task_memory    = 512

desired_count          = 1
minimum_capacity       = 1
maximum_capacity       = 2
target_cpu_utilization = 60

log_retention_days = 14

certificate_arn = null
domain_name     = "uat-portal.mycloudlab.space"

alb_ingress_cidrs = ["0.0.0.0/0"]

enable_container_insights = true
enable_execute_command    = false

tags = {
  OwnerTeam          = "FRHN-CloudEngineers"
  Application        = "FRHN-Portal"
  Workload           = "Web-Portal"
  DataClassification = "Demo"
}