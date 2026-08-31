locals {
  application_namespace = "frhn-prod"
  application_service   = "frhn-portal"
}

resource "aws_sns_topic" "pod_health" {
  name = "${var.cluster_name}-pod-health-alerts"

  tags = var.tags
}

resource "aws_sns_topic_subscription" "pod_health_email" {
  topic_arn = aws_sns_topic.pod_health.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_cloudwatch_metric_alarm" "running_pods" {
  alarm_name          = "${var.cluster_name}-running-pods-low"
  alarm_description   = "Alerts when fewer than two FRHN portal Pods are running."
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  threshold           = 2
  period              = 60
  statistic           = "Minimum"
  namespace           = "ContainerInsights"
  metric_name         = "service_number_of_running_pods"
  treat_missing_data  = "notBreaching"

  dimensions = {
    ClusterName = var.cluster_name
    Namespace   = local.application_namespace
    Service     = local.application_service
  }

  alarm_actions = [aws_sns_topic.pod_health.arn]
  ok_actions    = [aws_sns_topic.pod_health.arn]

  tags = var.tags
}

resource "aws_cloudwatch_dashboard" "eks_pods" {
  dashboard_name = "${var.cluster_name}-pod-observability"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          title   = "FRHN Portal Pod CPU Utilization"
          region  = var.aws_region
          view    = "timeSeries"
          period  = 60
          stat    = "Average"
          stacked = false

          metrics = [
            [
              "ContainerInsights",
              "pod_cpu_utilization",
              "Namespace",
              local.application_namespace,
              "ClusterName",
              var.cluster_name
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          title   = "FRHN Portal Pod Memory Utilization"
          region  = var.aws_region
          view    = "timeSeries"
          period  = 60
          stat    = "Average"
          stacked = false

          metrics = [
            [
              "ContainerInsights",
              "pod_memory_utilization",
              "Namespace",
              local.application_namespace,
              "ClusterName",
              var.cluster_name
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          title   = "FRHN Portal Pod Network Traffic"
          region  = var.aws_region
          view    = "timeSeries"
          period  = 60
          stat    = "Average"
          stacked = false

          metrics = [
            [
              "ContainerInsights",
              "pod_network_rx_bytes",
              "Namespace",
              local.application_namespace,
              "ClusterName",
              var.cluster_name
            ],
            [
              "ContainerInsights",
              "pod_network_tx_bytes",
              "Namespace",
              local.application_namespace,
              "ClusterName",
              var.cluster_name
            ]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6

        properties = {
          title   = "FRHN Portal Running Pods"
          region  = var.aws_region
          view    = "timeSeries"
          period  = 60
          stat    = "Minimum"
          stacked = false

          metrics = [
            [
              "ContainerInsights",
              "service_number_of_running_pods",
              "Service",
              local.application_service,
              "Namespace",
              local.application_namespace,
              "ClusterName",
              var.cluster_name
            ]
          ]
        }
      }
    ]
  })
}