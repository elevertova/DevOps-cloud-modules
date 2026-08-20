# Assembles the reusable VPC, container registry, and ECS platform modules.
# Environment-specific values are supplied through terraform.tfvars.

locals {
  name_prefix = "${lower(var.project_name)}-${var.environment}"

  container_environment = merge(
    {
      APP_NAME        = var.project_name
      APP_ENVIRONMENT = var.environment
    },
    var.domain_name == null ? {} : {
      PUBLIC_DOMAIN = var.domain_name
    }
  )
}

module "vpc" {
  source = "../../../modules/vpc"

  name_prefix        = local.name_prefix
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
  tags               = var.tags
}

module "container_registry" {
  source = "../../../modules/container-registry"

  repository_name      = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  scan_on_push         = true
  force_delete         = var.force_delete_repository
  tags                 = var.tags
}

module "ecs_platform" {
  source = "../../../modules/ecs-platform"

  name_prefix       = local.name_prefix
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids

  task_subnet_ids = var.use_private_task_subnets ? (
    module.vpc.private_subnet_ids
    ) : (
    module.vpc.public_subnet_ids
  )

  assign_public_ip = !var.use_private_task_subnets

  container_image = "${module.container_registry.repository_url}:${var.image_tag}"
  container_name  = "frhn-portal"
  container_port  = var.container_port
  task_cpu        = var.task_cpu
  task_memory     = var.task_memory

  desired_count          = var.desired_count
  minimum_capacity       = var.minimum_capacity
  maximum_capacity       = var.maximum_capacity
  target_cpu_utilization = var.target_cpu_utilization

  log_retention_days                = var.log_retention_days
  certificate_arn                   = var.certificate_arn
  alb_ingress_cidrs                 = var.alb_ingress_cidrs
  environment_variables             = local.container_environment
  enable_container_insights         = var.enable_container_insights
  enable_execute_command            = var.enable_execute_command
  health_check_path                 = "/"
  health_check_grace_period_seconds = 60

  tags = var.tags
}