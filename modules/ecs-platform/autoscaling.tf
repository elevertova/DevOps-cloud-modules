# Configures target-tracking auto scaling for the ECS service.

resource "aws_appautoscaling_target" "ecs_service" {
  service_namespace  = "ecs"
  scalable_dimension = "ecs:service:DesiredCount"
  resource_id        = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  min_capacity       = var.minimum_capacity
  max_capacity       = var.maximum_capacity
}

resource "aws_appautoscaling_policy" "cpu" {
  name               = "${var.name_prefix}-cpu-target-tracking"
  policy_type        = "TargetTrackingScaling"
  service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace
  scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
  resource_id        = aws_appautoscaling_target.ecs_service.resource_id

  target_tracking_scaling_policy_configuration {
    target_value       = var.target_cpu_utilization
    scale_in_cooldown  = 120
    scale_out_cooldown = 60

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}