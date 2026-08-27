output "repository_name" {
  description = "Name of the ECR repository."
  value       = module.container_registry.repository_name
}

output "repository_url" {
  description = "URL used to tag and push Docker images."
  value       = module.container_registry.repository_url
}
