# Exposes repository information required by Docker, ECS, and CI/CD pipelines.

output "repository_arn" {
  description = "ARN of the Amazon ECR repository."
  value       = aws_ecr_repository.this.arn
}

output "repository_name" {
  description = "Name of the Amazon ECR repository."
  value       = aws_ecr_repository.this.name
}

output "repository_url" {
  description = "URL used to tag, push, and pull container images."
  value       = aws_ecr_repository.this.repository_url
}

output "registry_id" {
  description = "AWS account ID of the Amazon ECR registry."
  value       = aws_ecr_repository.this.registry_id
}