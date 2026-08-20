# Exposes ECS platform details for DNS, validation, CI/CD, and presentations.

output "cluster_arn" {
  description = "ARN of the ECS cluster."
  value       = aws_ecs_cluster.this.arn
}

output "cluster_name" {
  description = "Name of the ECS cluster."
  value       = aws_ecs_cluster.this.name
}

output "service_name" {
  description = "Name of the ECS service."
  value       = aws_ecs_service.this.name
}

output "task_definition_arn" {
  description = "ARN of the active ECS task definition revision."
  value       = aws_ecs_task_definition.this.arn
}

output "load_balancer_arn" {
  description = "ARN of the Application Load Balancer."
  value       = aws_lb.this.arn
}

output "load_balancer_dns_name" {
  description = "AWS-generated DNS name of the Application Load Balancer."
  value       = aws_lb.this.dns_name
}

output "load_balancer_zone_id" {
  description = "Canonical hosted-zone ID of the Application Load Balancer."
  value       = aws_lb.this.zone_id
}

output "target_group_arn" {
  description = "ARN of the ECS Application Load Balancer target group."
  value       = aws_lb_target_group.this.arn
}

output "alb_security_group_id" {
  description = "ID of the Application Load Balancer security group."
  value       = aws_security_group.alb.id
}

output "task_security_group_id" {
  description = "ID of the ECS task security group."
  value       = aws_security_group.tasks.id
}

output "task_execution_role_arn" {
  description = "ARN of the ECS task execution role."
  value       = aws_iam_role.task_execution.arn
}

output "task_role_arn" {
  description = "ARN of the application task role."
  value       = aws_iam_role.task.arn
}

output "log_group_name" {
  description = "Name of the CloudWatch container log group."
  value       = aws_cloudwatch_log_group.this.name
}

output "application_url" {
  description = "ALB URL available before the custom DNS record is created."
  value = var.certificate_arn == null ? (
    "http://${aws_lb.this.dns_name}"
    ) : (
    "https://${aws_lb.this.dns_name}"
  )
}