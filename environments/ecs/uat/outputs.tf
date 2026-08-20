# Exposes environment deployment details for verification, DNS, and CI/CD.

output "environment" {
  description = "Name of the deployed environment."
  value       = var.environment
}

output "repository_url" {
  description = "URL of the environment's ECR repository."
  value       = module.container_registry.repository_url
}

output "container_image" {
  description = "Complete ECR image URI used by the ECS task definition."
  value       = "${module.container_registry.repository_url}:${var.image_tag}"
}

output "cluster_name" {
  description = "Name of the ECS cluster."
  value       = module.ecs_platform.cluster_name
}

output "service_name" {
  description = "Name of the ECS service."
  value       = module.ecs_platform.service_name
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition revision."
  value       = module.ecs_platform.task_definition_arn
}

output "load_balancer_dns_name" {
  description = "AWS-generated DNS name of the Application Load Balancer."
  value       = module.ecs_platform.load_balancer_dns_name
}

output "application_url" {
  description = "Application URL using the load balancer."
  value       = module.ecs_platform.application_url
}

output "custom_domain_name" {
  description = "Custom DNS name assigned to the environment."
  value       = var.domain_name
}

output "log_group_name" {
  description = "CloudWatch log group used by the application."
  value       = module.ecs_platform.log_group_name
}